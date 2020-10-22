# Starfall Hammer Library
## How to install:
1. Install StarfallEx from https://github.com/thegrb93/StarfallEx (not sure why you'd be using this without it though)
2. Download this repo and put hammer.lua into garrysmod/lua/starfall/libs_sv

## How to set up:
1. Open Hammer and compile your map that you wish to edit in-game
2. Open your map in Garry's Mod
3. Begin a session using hammer.startSession()
   - Note: You MUST be running the same version of the map in Hammer and Garry's Mod.
4. Use whatever functions you wish to place entities in Hammer
5. End the editing session using hammer.endSession()
6. Your changes should appear in Hammer!

## Basic function usage:
`hammer.sendCommand(cmd)` - Sends a command to Hammer. Arguments:
1. `cmd` - String - The command to send

`hammer.startSession()` - Begins an editing session.

`hammer.endSession()` - Ends an editing session.

`hammer.createEntity(class, pos)` - Creates an entity. Arguments:
1. `class` - String - Class of the entity
2. `pos` - Vector - Position of the entity

`hammer.removeEntity(class, pos)` - Removes an entity. Arguments:
1. `class` - String - Class of the entity
2. `pos` - Vector - Position of the entity

`hammer.setKeyValue(class, pos, key, value)` - Sets an entity's KeyValue pair. Arguments:
1. `class` - String - Class of the entity
2. `pos` - Vector - Position of the entity
3. `key` -  String - Key to set
4. `value` -  String - Value to set

`hammer.rotateIncremental(class, pos, ang)` - Incrementally rotates an entity. Arguments:
1. `class` -  String - Class of the entity
2. `pos` - Vector - Position of the entity
3. `ang` - Angle - Angle to rotate the entity by

`hammer.createNode(class, id, pos)` - Creates an AI node. Arguments:
1. `class` - String - Class of the node
2. `id` - Number - ID of the node
3. `pos` - Vector - Position of the node

`hammer.removeNode(id)` - Removes an AI node. Arguments:
1. `id` - Number - ID of the node

`hammer.createNodeLink(startID, endID)` - Creates a link between two AI nodes. Arguments:
1. `startID` - Number - First node ID
2. `endID` - Number - Second node ID

`hammer.removeNodeLink(startID, endID)` - Removes a link between two AI nodes. Arguments:
1. `startID` - Number - First node ID
2. `endID` - Number - Second node ID

`hammer.createProp(type, model, pos, ang)` - Creates a prop. Arguments:
1. `type` -  String - Type of prop ("physics", "dynamic", "dynamic_override", or "static")
2. `model` -  String - Model of the prop
3. `pos` - Vector - Position of the prop
4. `ang` - Angle - Angle of the prop

## Additional Info
I made a chip to make use of these functions! Check out my [vegetation placer!](https://gist.github.com/CheezusChrust/18845f7b41b9cceb171aa52a10d19855)
