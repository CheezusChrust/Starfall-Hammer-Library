--- Hammer library.
-- @server

if not game.SinglePlayer() then return end

local checktype = SF.CheckType
local checkluatype = SF.CheckLuaType
local mapName = game.GetMap()
local vBSPMapVer = game.GetMapVersion()
local mapVer = vBSPMapVer --This works for now

local hammer_library = SF.RegisterLibrary("hammer")

SF.AddHook("postload", function()
	ang_meta = SF.Angles.Metatable
	vec_meta = SF.Vectors.Metatable
end)

function matrixToString(matrix, iscolor)
    if iscolor then
        return " "..matrix.r.." "..matrix.g.." "..matrix.b
    else
        return " "..matrix[1].." "..matrix[2].." "..matrix[3]
    end
end

--[[
function hammer_library.toString(vec)
    checkluatype(vec, TYPE_VECTOR)
    return tostring(vec.x) .. " " .. tostring(vec.y) .. " " .. tostring(vec.z)
end
--]]

function hammer_library.sendCommand(cmd)
    checkluatype(cmd, TYPE_STRING)
    local result = hammer.SendCommand(cmd)
    if result == "ok" then return true else SF.Throw("Bad command", 2) end
end

function hammer_library.startSession()
    for i=0,10 do
        local result = hammer.SendCommand("session_begin " .. mapName .. " " .. mapVer + i)
        if result == "ok" then return true end
    end
    SF.Throw("Could not begin session due to map version difference, re-compile your map", 2)
end

function hammer_library.endSession()
    local result = hammer.SendCommand("session_end")
    if result == "ok" then return true else SF.Throw("No session to be ended", 2) end
end

function hammer_library.createEntity(class, pos)
    checkluatype(class, TYPE_STRING)
    checktype(pos, vec_meta)
    local pos = matrixToString(pos, false)
    local result = hammer.SendCommand("entity_create " .. class .. " " .. pos)
    if result == "ok" then return true else SF.Throw("Entity could not be created", 2) end
end

function hammer_library.removeEntity(class, pos)
    checkluatype(class, TYPE_STRING)
    checktype(pos, vec_meta)
    local pos = matrixToString(pos, false)
    local result = hammer.SendCommand("entity_delete " .. class .. " " .. pos)
    if result == "ok" then return true else SF.Throw("Entity could not be removed", 2) end
end

function hammer_library.setKeyValue(class, pos, key, value)
    checkluatype(class, TYPE_STRING)
    checktype(pos, vec_meta)
    checkluatype(key, TYPE_STRING)
    checkluatype(value, TYPE_STRING)
    local pos = matrixToString(pos, false)
    local result = hammer.SendCommand("entity_set_keyvalue " .. class .. " " .. pos .. " \"" .. key .. "\" \"" .. value .. "\"")
    if result == "ok" then return true else SF.Throw("KeyValue could not be set", 2) end
end

function hammer_library.rotateIncremental(class, pos, ang)
    checkluatype(class, TYPE_STRING)
    checktype(pos, vec_meta)
    checktype(pos, ang_meta)
    local pos = matrixToString(pos, false)
    local ang = matrixToString(ang, false)
    local result = hammer.SendCommand("entity_rotate_incremental " .. class .. " " .. pos .. " " .. ang)
    if result == "ok" then return true else SF.Throw("Entity could not be rotated", 2) end
end

function hammer_library.createNode(class, id, pos)
    checkluatype(class, TYPE_STRING)
    checkluatype(id, TYPE_NUMBER)
    checktype(pos, vec_meta)
    local pos = matrixToString(pos, false)
    local result = hammer.SendCommand("node_create " .. class .. " " .. id .. " " .. pos)
    if result == "ok" then return true else SF.Throw("Node could not be created", 2) end
end

function hammer_library.removeNode(id)
    checkluatype(id, TYPE_NUMBER)
    local result = hammer.SendCommand("node_delete " .. id)
    if result == "ok" then return true else SF.Throw("Node could not be removed", 2) end
end

function hammer_library.createNodeLink(startID, endID)
    checkluatype(startID, TYPE_NUMBER)
    checkluatype(endID, TYPE_NUMBER)
    local result = hammer.SendCommand("nodelink_create " .. startID .. " " .. endID)
    if result == "ok" then return true else SF.Throw("Nodes could not be linked", 2) end
end

function hammer_library.removeNodeLink(startID, endID)
    checkluatype(startID, TYPE_NUMBER)
    checkluatype(endID, TYPE_NUMBER)
    local result = hammer.SendCommand("nodelink_delete " .. startID .. " " .. endID)
    if result == "ok" then return true else SF.Throw("Nodes could not be unlinked", 2) end
end

function hammer_library.createProp(type, model, pos, ang)
    checkluatype(type, TYPE_STRING)
    checkluatype(model, TYPE_STRING)
    checktype(pos, vec_meta)
    checktype(ang, ang_meta)
    pos = matrixToString(pos, false)
    ang = matrixToString(ang, false)
    local result = hammer.SendCommand("entity_create prop_" .. type .. " " .. pos)
    if result ~= "ok" then SF.Throw("Prop could not be created", 2) end
    result = hammer.SendCommand("entity_set_keyvalue prop_" .. type .. " " .. pos .. " \"model\" \"" .. model .. "\"")
    if result ~= "ok" then SF.Throw("Prop model could not be set", 2) end
    result = hammer.SendCommand("entity_set_keyvalue prop_" .. type .. " " .. pos .. " \"angles\" \"" .. ang .. "\"")
    if result ~= "ok" then SF.Throw("Prop angles could not be set", 2) end
    return true
end

--[[
function ents_methods:sendToHammer(type)
    checktype(self, ents_metatable)
    checkluatype(type, TYPE_STRING)
end
--]]