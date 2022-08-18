# NDS-Ironmon-Tracker


https://user-images.githubusercontent.com/61294586/173255404-ecd702ad-b23d-4b1c-a6ce-b98c09270c9d.mp4



This tracker is a lua script that runs with [BizHawk's](https://tasvideos.org/BizHawk/ReleaseHistory) melonDS core. It's made primarily for the ironMON challenge(created by Iateyourpie) and is used to track Pokémon data dynamically.

- For more information on this challenge, head on over to [ironmon.gg](http://ironmon.gg)
- Come join the amazing Discord! https://discord.gg/jFPYsZAhjX

This tracker is based on the Nintendo DS (NDS) Pokémon games. As such, the following games are currently supported:

- Pokémon Diamond/Pearl
- Pokémon Platinum
- Pokémon HeartGold/SoulSilver
- Pokémon Black/White (functional but not perfect yet)

A lot of this project came directly from https://github.com/besteon/Ironmon-Tracker, so I cannot thank them and all of the project's contributors enough for all the amazing groundwork they did. Also, huge shoutouts to the people over at projectpokemon.org for all their technical documentation on Pokémon data.

## Installation

1. If you don't have BizHawk, [download the emulator](https://tasvideos.org/BizHawk/ReleaseHistory) (v2.8 or higher).
   - **IMPORTANT**: **Run BizHawk once and close it.**  This creates a config file in BizHawk's folder that ensures the tracker will work correctly. If you don't do 			this, errors may occur.
2. Download this tracker from the [releases](https://github.com/Brian0255/NDS-Ironmon-Tracker/releases/) section.
3. Unzip the tracker's files to a location of your choosing. One good location is the `Lua` folder where you installed BizHawk. Make sure the "ironmon_tracker" folder is in the same directory as "Ironmon_Tracker.lua".
4. Configure your settings in the `Settings.ini` file, or click the gear icon when the tracker is loaded. Descriptions for settings and what they do are in the `Settings.ini` file.
5. Load your ROM into [BizHawk](https://tasvideos.org/BizHawk/ReleaseHistory).
6. Open the Lua Console (Tools -> Lua Console). Click on the folder icon and open `Ironmon_Tracker.lua` in the location you extracted it to.
   - If you installed the tracker in Bizhawk's `Lua` folder, this location is shown by default and you should see the `Ironmon_Tracker.lua` file right away.

**IMPORTANT (GEN 4 GAMES): Do not change the system clock in the melonDS settings.** This will shift the memory around and the tracker will not work. Currently there is no workaround for this yet. The settings should look like this (under NDS -> Settings -> Sync Settings once the NDS ROM is loaded).

![image](https://user-images.githubusercontent.com/61294586/173255514-90c40ced-dcbd-4fae-bc41-a4ede0046db9.png)

## Main Features

- **Automatic Pokémon Tracking**: All of your Pokémon's data are updated as you play! Its stats, nature, moves(and various information about them), ability, and typing are all shown for you. No more having to bring up the summary constantly!

- **Stat Increases and Decreases**: Moves that change stats (such as `Dragon Dance`, `Tail Glow`, and `Tail Whip`) will be shown on the tracker next to the pokemon's stats. Positive stat increases will be shown with up arrows that turn green, and negative will be shown with down arrows that turn red.

- **Enemy Moves**: Enemy Pokémon moves are tracked for you as well! Just in a little bit of a different way. Once you've seen an enemy pokemon's move, the tracker will display it. If you encounter that same Pokémon later, the move will have an asterisk `*` next to it, which means it might not have the move anymore.

- **Predicting Enemy Stats**: Think an enemy is massive tank? Think an enemy hits like a truck? Well you can mark that in the tracker! When viewing an enemy pokemon, just click the boxes next to the enemy Pokémon's stats, and it will cycle through `+`, `-`, and blank.

- **Move effectiveness**: Knowing what moves are super effective and such can be tricky! For your convenience, that can be done for you. When a move is super effective, it will display green up arrows depending on x2 or x4. Not very effective moves will display red down arrows in a similar fashion. If a move can't hit at all (like normal types and ghost types), a red "X' will be displayed.

- **Attack type icons**: The Physical/Special split on moves can be a LOT to remember. Luckily, the tracker will display this information for you! Depending on if a move is physical or special, a small icon will be displayed to the left of the move's name. If it's a status move, no icon will be displayed.

- **Healing items**: The tracker also has the capability to track how many heals you have and display the total heals as a percent of your HP. For example, if my Pokémon had 40 HP and 3 potions, it would display "Heals in Bag: 150%". Super helpful!

- **Quick loading seeds**: The tracker has a very nice feature to auto-load the next seed, which you can accomplish with the following:
	1. Create a bunch of seeds with a .bat file (check the Ironmon discord in the getting-started channel)
  2. Ensure that the seeds are in a format like `seed1.nds`, `seed2.nds`, `seed3.nds`, etc. `seed0003`, `S33D3`, and `34555_1` will not work.
	3. Once you've been sent back to the lab and need to load the next seed, use the NEXT_SEED button combo in the Settings file.
		- By default, the button combo is A,B,Start,Select.
		
- **Notes**: You can leave a quick note about an enemy Pokémon by clicking the note button at the bottom left of the tracker.
	- **WARNING:** The notes feature can potentially cause slowdown. I would recommend you use Notepad++ or something similar to keep notes instead.

## Feedback

- Found a bug or the program stopped working? Did Aura Sphere have a missing category icon? Great! For stuff like this, you can open up an issue on the project [here,](https://github.com/Brian0255/NDS-Ironmon-Tracker/issues) or just DM me on Discord (OnlySpaghettiCode#1024). I am more than happy to respond to feedback and bug reports!
-  Think you have a cool idea for the tracker or just want to give feedback? I'd love to hear it! Feel free to DM me on Discord or open up an issue on the project. 

## FAQ

### Common errors and solutions

---

Error: `Can't have lua running in two host threads at a time!`

Cause: Outdated version of Bizhawk

Fix: Use [Bizhawk emulator](https://tasvideos.org/BizHawk/ReleaseHistory) version 2.8 or higher

---

Error: `ironmon_tracker/ironmon_tracker.lua: attempt to index field 'field' (a nil value)`

Cause: Updating to a new version of the tracker and using a savestate from an older version.

Fix: Only update the tracker between runs when you can make a new savestate.

---

Error: `NullHawk does not implement memory domains NLua.Exceptions.LuaException: unprotected error in call to Lua API (0)`

Cause: Your roms must not have spaces in the names, or the `ROMS_FOLDER` path specified in `Settings.ini` is not correct. Your rom number also can't have leading zeros, such as Kaizo001.nds, Kaizo002.nds, etc. They must be Kaizo1.nds, Kaizo2.nds, etc.

Fix: Rename your roms so they don't have spaces in the names.

---

Error: `ironmon_tracker/ironmon_tracker.lua: attempt to index field '?' (a nil value)`

Cause: Usually happens when you run the tracker without opening and closing BizHawk at least once.

Fix: Open and close BizHawk at least once to generate the config.ini file.

