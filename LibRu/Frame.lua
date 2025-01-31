LibRu = LibRu or {};


LibRu.Frame = LibRu.Frame or {};

local Frame = LibRu.Frame;


--[[
    Creates an instance of a Frame.
    Will call CreateFrame (WoW API). And then add additional properties to it.
]]
function Frame:New(frameType, frameName, parentFrame, template)
    local instance = CreateFrame(frameType, frameName, parentFrame, template);

    -- Get the existing metatable of the Frame (could be a table or function)
    local frameMeta = getmetatable(instance);

    -- Create a new metatable for obj that merges blizzard Frame and PoopieLib's frame
    setmetatable(instance, {
        __index = function(t, k)
            -- Check Frame class first
            if Frame[k] then return Frame[k] end
            
            -- Check if the blizzard Frame metatable has an __index (table or function)
            if frameMeta and type(frameMeta.__index) == "table" then
                return frameMeta.__index[k]  -- Standard table lookup
            elseif frameMeta and type(frameMeta.__index) == "function" then
                return frameMeta.__index(t, k)  -- Call function-based lookup
            end
            
            return nil  -- Key not found
        end
    })

    instance.heightMode = "auto"

    return instance
end


function Frame:FitHeightToContent(recursive, ignoreHidden, recursionLevel)
    -- set recursion level
    if recursionLevel == nil then 
        recursionLevel = 0; 
    end

    -- get all contents
    local contents = LibRu.GetAllChildObjects(self);

    if (#contents == 0) then return end;

    -- apply recursion if necessary
    if (recursive) then
        for i = 1, #contents, 1 do 
            if contents[i].FitHeightToContent then 
                contents[i]:FitHeightToContent(recursive, ignoreHidden, recursionLevel + 1);
            end
        end
    end

    if recursionLevel == 0 or self.heightMode == "auto" then
        LibRu.FitFrameHeightToContent(self, ignoreHidden); 
    end
end