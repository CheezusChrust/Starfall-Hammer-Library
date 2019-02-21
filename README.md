# Starfall Hammer Library

## Basic usage:
`hammer.sendCommand(cmd)` - Sends a command to Hammer. Arguments:
1. `cmd` - The command to send

`hammer.startSession()` - Begins an editing session.

`hammer.endSession()` - Ends an editing session.

`hammer.createEntity(class, pos)` - Creates an entity. Arguments:
1. `class` - Class of the entity
2. `pos` - Position of the entity

`hammer.removeEntity(class, pos)` - Removes an entity. Arguments:
1. `class` - Class of the entity
2. `pos` - Position of the entity

`hammer.setKeyValue(class, pos, key, value)` - Sets an entity's KeyValue pair. Arguments:
1. `class` - Class of the entity
2. `pos` - Position of the entity
3. `key` - Key to set
4. `value` - Value to set

`hammer.rotateIncremental(class, pos, ang)` - Incrementally rotates an entity. Arguments:
1. `class` - Class of the entity
2. `pos` - Position of the entity
3. `ang` - Angle to rotate the entity by

`hammer.createNode(class, id, pos)` - Creates an AI node. Arguments:
1. `class` - Class of the node
2. `id` - ID of the node
3. `pos` - Position of the node

`hammer.removeNode(id)` - Removes an AI node. Arguments:
1. `id` - ID of the node

`hammer.createNodeLink(startID, endID)` - Creates a link between two AI nodes. Arguments:
1. `startID` - First node ID
2. `endID` - Second node ID

`hammer.removeNodeLink(startID, endID)` - Removes a link between two AI nodes. Arguments:
1. `startID` - First node ID
2. `endID` - Second node ID

`hammer.createProp(type, model, pos, ang)` - Creates a prop. Arguments:
1. `type` - Type of prop (physics, dynamic, dynamic_override, or static)
2. `model` - Model of the prop
3. `pos` - Position of the prop
4. `ang` - Angle of the prop
