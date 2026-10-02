# Running under melonDS's Android port

This fork includes a handful of small, optional patches (see the
`android-compatibility` branch) that let this tracker run under
[melonDS](https://melonds.kuribo64.net/)'s Android port, in addition to
BizHawk on desktop.

## Why this is needed

A few of the tracker's features shell out to the OS via `os.execute()` /
`io.popen()` (resolving the tracker's own directory, checking for and
installing updates, opening the release notes link). That works fine under
BizHawk on Windows/Linux, but it can't work the same way in a sandboxed
Android app process -- there's no shell to exec, and on melonDS's Android
build, the Lua interpreter disables `os.execute()`/`io.popen()` entirely
rather than let them crash the whole script.

## The `android` global

To let the tracker use real Android functionality in their place, melonDS's
Android build defines an extra Lua global, `android`, alongside the usual
`gui`, `client`, `forms`, etc. tables -- but **only when the script is
actually running inside melonDS's Android Lua interpreter**. It is never
defined under real BizHawk, nor under melonDS's own desktop build, so
`android` is simply `nil` in every other environment.

Currently provided:

| Function | Purpose |
|---|---|
| `android.getScriptDirectory()` | Returns the running script's own directory, without shelling out to `pwd`/`cd`. |
| `android.httpGet(url)` | Performs an HTTP GET and returns the response body, or `nil` on failure. |
| `android.downloadAndExtractUpdate(url, destDir)` | Downloads a `.tar.gz` and extracts it into `destDir`, replacing the `curl`/`tar`/`cp` pipeline `os.execute()` would otherwise run. |
| `android.openUrl(url)` | Opens a URL in the device's browser (an Android `Intent.ACTION_VIEW`), replacing `os.execute('start "" "<url>"')`. |
| `android.consumeNewRunRequested()` | Returns `true` (once) if the app's touch-friendly "start a new run" button was tapped, as an alternative to holding the real Start+Select+A+B combo on a touchscreen. |

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
this check is always safe to write, even in a file that's never run on
melonDS's Android build at all. Outside of melonDS's Android port, every one
of these branches is dead code, so the tracker's behavior under BizHawk and
desktop melonDS is unchanged.

## Where this comes from

`android` and its functions are implemented natively in melonDS's own
source (`LuaScriptManager.cpp`'s `registerAPI()`), not by this tracker --
there's nothing to install or configure here beyond running the tracker on
a build of melonDS that defines it.
