if not game.SinglePlayer() then return end

local checkluatype = SF.CheckLuaType
local mapName = game.GetMap()
local mapVer = game.GetMapVersion()


--- Library for placing and editing entities within a Hammer session
-- @name hammer
-- @class library
-- @libtbl hammer_library
SF.RegisterLibrary("hammer")

return function(instance)

local checktype = instance.CheckType
local hammer_library = instance.Libraries.hammer
local ang_meta, vec_meta = instance.Types.Angle, instance.Types.Vector

instance:AddHook("deinitialize", function()
    hammer.SendCommand("session_end")
end)

local function matrixToString(matrix)
    return matrix[1] .. " " .. matrix[2] .. " " .. matrix[3]
end

local function send(cmd, msgOnFail)
    if hammer.SendCommand(cmd) ~= "ok" then
        SF.Throw(msgOnFail, 3)
    end

    return true
end

--- Sends a command.
-- @param cmd The command to send
-- @return True if the command was successful
function hammer_library.sendCommand(cmd)
    checkluatype(cmd, TYPE_STRING)

    return send(cmd, "Bad command")
end

--- Starts an editing session.
-- @return True if the command was successful
function hammer_library.startSession()
    for i = 0, 10 do
        local result = hammer.SendCommand("session_begin " .. mapName .. " " .. mapVer + i)
        if result == "ok" then return true end
    end

    SF.Throw("Could not begin session due to map version difference, re-compile your map", 2)
end

--- Ends an editing session.
-- @return True if the command was successful
function hammer_library.endSession()
    return send("session_end", "No session to be ended")
end

--- Creates an entity.
-- @param class Class of the entity
-- @param pos Position of the entity
-- @return True if the command was successful
function hammer_library.createEntity(class, pos)
    checkluatype(class, TYPE_STRING)
    checktype(pos, vec_meta)
    pos = matrixToString(pos)
    return send("entity_create " .. class .. " " .. pos, "Entity could not be created")
end

--- Removes an entity.
-- @param class Class of the entity
-- @param pos Position of the entity
-- @return True if the command was successful
function hammer_library.removeEntity(class, pos)
    checkluatype(class, TYPE_STRING)
    checktype(pos, vec_meta)
    pos = matrixToString(pos)

    return send("entity_delete " .. class .. " " .. pos, "Entity could not be removed")
end

--- Sets an entity's KeyValue pair.
-- @param class Class of the entity
-- @param pos Position of the entity
-- @param key Key to set
-- @param value Value to set
-- @return True if the command was successful
function hammer_library.setKeyValue(class, pos, key, value)
    checkluatype(class, TYPE_STRING)
    checktype(pos, vec_meta)
    checkluatype(key, TYPE_STRING)
    checkluatype(value, TYPE_STRING)
    pos = matrixToString(pos)

    return send("entity_set_keyvalue " .. class .. " " .. pos .. " \"" .. key .. "\" \"" .. value .. "\"", "KeyValue could not be set")
end

--- Incrementally rotates an entity.
-- @param class Class of the entity
-- @param pos Position of the entity
-- @param ang Angle to rotate the entity by
-- @return True if the command was successful
function hammer_library.rotateIncremental(class, pos, ang)
    checkluatype(class, TYPE_STRING)
    checktype(pos, vec_meta)
    checktype(ang, ang_meta)
    pos = matrixToString(pos)
    ang = matrixToString(ang)

    return send("entity_rotate_incremental " .. class .. " " .. pos .. " " .. ang, "Entity could not be rotated")
end

local floor = math.floor

--- Creates an AI node.
-- @param class Class of the node
-- @param id ID of the node
-- @param pos Position of the node
-- @return True if the command was successful
function hammer_library.createNode(class, id, pos)
    checkluatype(class, TYPE_STRING)
    checkluatype(id, TYPE_NUMBER)

    id = floor(id)

    checktype(pos, vec_meta)
    pos = matrixToString(pos)

    return send("node_create " .. class .. " " .. id .. " " .. pos, "Node could not be created")
end

--- Removes an AI node.
-- @param id ID of the node
-- @return True if the command was successful
function hammer_library.removeNode(id)
    checkluatype(id, TYPE_NUMBER)

    id = floor(id)

    return send("node_delete " .. id, "Node could not be removed")
end

--- Creates a link between two AI nodes.
-- @param startID First node ID
-- @param endID Second node ID
-- @return True if the command was successful
function hammer_library.createNodeLink(startID, endID)
    checkluatype(startID, TYPE_NUMBER)
    checkluatype(endID, TYPE_NUMBER)

    startID = floor(startID)
    endID = floor(endID)

    return send("nodelink_create " .. startID .. " " .. endID, "Nodes could not be linked")
end

--- Removes a link between two AI nodes.
-- @param startID First node ID
-- @param endID Second node ID
-- @return True if the command was successful
function hammer_library.removeNodeLink(startID, endID)
    checkluatype(startID, TYPE_NUMBER)
    checkluatype(endID, TYPE_NUMBER)

    startID = floor(startID)
    endID = floor(endID)

    return send("nodelink_delete " .. startID .. " " .. endID, "Nodes could not be unlinked")
end

local validPropClasses = {
    physics = true,
    dynamic = true,
    dynamic_override = true,
    static = true
}

--- Creates a prop.
-- @param class Class of prop (physics, dynamic, dynamic_override, or static)
-- @param model Model of the prop
-- @param pos Position of the prop
-- @param ang Angle of the prop
-- @return True if the command was successful
function hammer_library.createProp(class, model, pos, ang)
    checkluatype(class, TYPE_STRING)

    if not validPropClasses[class] then
        SF.Throw("Invalid prop class", 2)
    end

    checkluatype(model, TYPE_STRING)
    checktype(pos, vec_meta)
    checktype(ang, ang_meta)

    pos = matrixToString(pos)
    ang = matrixToString(ang)

    send("entity_create prop_" .. class .. " " .. pos, "Prop could not be created")
    send("entity_set_keyvalue prop_" .. class .. " " .. pos .. " \"model\" \"" .. model .. "\"", "Prop model could not be set")

    return send("entity_set_keyvalue prop_" .. class .. " " .. pos .. " \"angles\" \"" .. ang .. "\"", "Prop angles could not be set")
end

end