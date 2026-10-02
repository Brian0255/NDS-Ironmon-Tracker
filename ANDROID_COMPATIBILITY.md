# Running under an Android-based emulator

This fork includes a handful of small, optional patches (see the
`android-compatibility` branch) that let this tracker run under an
Android-based emulator, in addition to BizHawk on desktop -- for example,
[melonDS](https://melonds.kuribo64.net/)'s Android port, which is what these
patches were originally written against.

## Why this is needed

A few of the tracker's features shell out to the OS via `os.execute()` /
`io.popen()` (resolving the tracker's own directory, checking for and
installing updates, opening the release notes link). That works fine under
BizHawk on Windows/Linux, but it can't work the same way in a sandboxed
Android app process -- there's no shell to exec, and an Android build's Lua
interpreter may disable `os.execute()`/`io.popen()` entirely rather than let
them crash the whole script (melonDS's Android port does exactly this).

## The `android` global

To let the tracker use real Android functionality in their place, an
Android build can define an extra Lua global, `android`, alongside the
usual `gui`, `client`, `forms`, etc. tables -- but **only when the script is
actually running inside that Android build's Lua interpreter**. It is never
defined under real BizHawk, nor under desktop melonDS, so `android` is
simply `nil` in every other environment.

Currently provided (as implemented by melonDS's Android port):

| Function | Purpose |
|---|---|
| `android.getScriptDirectory()` | Returns the running script's own directory, without shelling out to `pwd`/`cd`. |
| `android.httpGet(url)` | Performs an HTTP GET and returns the response body, or `nil` on failure. |
| `android.downloadAndExtractUpdate(url, destDir)` | Downloads a `.tar.gz` and extracts it into `destDir`, replacing the `curl`/`tar`/`cp` pipeline `os.execute()` would otherwise run. |
| `android.openUrl(url)` | Opens a URL in the device's browser (an Android `Intent.ACTION_VIEW`), replacing `os.execute('start "" "<url>"')`. |
| `android.consumeNewRunRequested()` | Returns `true` (once) if the app's touch-friendly "start a new run" button was tapped, as an alternative to holding the real Start+Select+A+B combo on a touchscreen. |
| `android.setOverlayScrollEnabled(enabled)` | Lets the user manually drag the overlay horizontally to reveal content past its normal right-anchored view (e.g. this tracker's Statistics/Log Viewer screens, which draw into the side of the overlay that's otherwise cropped off-screen). Off by default; call every frame a screen that needs it is shown, same as `client.SetGameExtraPadding()`. |

## How the patches use it

Every patch on the `android-compatibility` branch follows the same shape:

```lua
if android ~= nil and android.someFunction ~= nil then
    -- take the Android path
else
    -- original behavior, completely unchanged
end
```

Since an undefined Lua global simply evaluates to `nil` (it doesn't error),
this check is always safe to write, even in a file that's never run on an
Android build at all. Outside of an Android emulator that defines this
global, every one of these branches is dead code, so the tracker's behavior
under BizHawk and desktop melonDS is unchanged.

## Where this comes from

`android` and its functions aren't provided by this tracker -- they're
implemented natively by whichever emulator is running it. In melonDS's
Android port, for example, this lives in `LuaScriptManager.cpp`'s
`registerAPI()`. There's nothing to install or configure here beyond
running the tracker on a build that defines this global.
