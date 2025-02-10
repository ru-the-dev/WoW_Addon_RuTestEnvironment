LibRu = LibRu or {};


---Returns all objects inside a frame, including child frames and regions.
---@param frame Frame Frame The parent frame to scan.
---@return table children table containing all child frames and regions.
local function GetAllChildObjects(frame)
    local childObjects = {}

    -- Get all child frames
    for _, child in ipairs({frame:GetChildren()}) do
        table.insert(childObjects, child)
    end

    -- Get all regions (textures, font strings, etc.)
    for _, region in ipairs({frame:GetRegions()}) do
        table.insert(childObjects, region)
    end

    return childObjects
end

LibRu.GetAllChildObjects = LibRu.GetAllChildObjects or GetAllChildObjects;


---Adds a (Nine-)Sliced texture to the frame
---@param frame Frame frame to add the texture to.
---@param texturePath string Path to the texture file
---@param left integer Left slice margin
---@param top? integer Top slice margin (left if nill)
---@param right? integer Right slice margin (left if nill)
---@param bottom? integer Bottom slice margin (left if nill)
---@return Texture texture Created sliced texture
local function CreateSlicedTexture(frame, texturePath, left, top, right, bottom)
    local texture = frame:CreateTexture(nil, "BACKGROUND");
    texture:SetTexture(texturePath)
    texture:SetAllPoints();

    texture:SetTextureSliceMargins(
        left,
        top or left,
        right or left, 
        bottom or left
    );

    texture:SetTextureSliceMode(1);

    return texture;
end

LibRu.CreateSlicedTexture = LibRu.CreateSlicedTexture or CreateSlicedTexture;


---Creates and returns a frame inside of the parent frame with the specified padding.
---@param frameType string "Frame" or "Button"
---@param frameName string Name of frame, may be nil
---@param parent Frame UIParent of inset frame
---@param inherits string New frame inherits
---@param paddingLeft number Left side padding
---@param paddingTop? number Top side padding (leftSide if nill)
---@param paddingRight? number Right side padding (leftSide if nill)
---@param paddingBottom? number Bottom side padding (leftside if nill)
---@return Frame insetFrame The created inset frame.
local function CreateInsetFrame(frameType, frameName, parent, inherits, paddingLeft, paddingTop, paddingRight, paddingBottom)
    local insetFrame = CreateFrame(frameType, frameName, parent, inherits);

    insetFrame:SetPoint("LEFT", paddingLeft, 0);
    insetFrame:SetPoint("TOP", 0, -(paddingTop or paddingLeft));
    insetFrame:SetPoint("RIGHT", -(paddingRight or paddingLeft), 0);
    insetFrame:SetPoint("BOTTOM", 0, paddingBottom or paddingLeft);

    return insetFrame;
end

LibRu.CreateInsetFrame = LibRu.CreateInsetFrame or CreateInsetFrame;


---Creates a standard resize button and adds it to the parent frame.<br>
---Sets the resize frame to Resizable and MouseEnabled.
---@param parent Frame Parent frame.
---@param resizeFrame Frame Frame to resize
---@param size? number Size of button.
---@param resizeAnchor? number Size of button.
---@return Frame resizeButton The Created Button.        
local function CreateResizeButton(parent, resizeFrame, size, resizeAnchor)
    resizeFrame:SetResizable(true);
    resizeFrame:EnableMouse(true);
    
    local resizeButton = CreateFrame("Button", nil, parent);
    resizeButton:SetSize(size or 20, size or 20);
    resizeButton:SetPoint(resizeAnchor or "BOTTOMRIGHT")

    resizeButton.t_texture = resizeButton:CreateTexture(nil, "OVERLAY");
    resizeButton.t_texture:SetTexture("interface\\CHATFRAME\\UI-ChatIM-SizeGrabber-Up");
    resizeButton.t_texture:SetAllPoints();

    resizeButton:SetScript("OnMouseDown", function()
        resizeFrame:StartSizing(resizeAnchor or "BOTTOMRIGHT")
    end)

    resizeButton:SetScript("OnMouseUp", function()
        resizeFrame:StopMovingOrSizing()
    end)

    return resizeButton;
end

LibRu.CreateResizeButton = LibRu.CreateResizeButton or CreateResizeButton;

---Adjusts a frame's height to fit all of its contents.
---@param frame Frame Frame to fit to the contents
---@param ignoreHidden boolean Wether or not to ignore hidden items.
local function FitFrameHeightToContent(frame, ignoreHidden)
    -- for contents to count as "Shown" height must be at least 1px
    -- ensure contents are atleast rendered so we can get their top and bottoms
    frame:SetHeight(1)
    
    local children = LibRu.GetAllChildObjects(frame);

    if (#children == 0) then
        frame:SetHeight(0);
        return;
    end

    local maxTop = 0;
    local minBottom = math.huge;

    -- Iterate over children to find the highest top and lowest bottom
    for _, child in ipairs(children) do
        if (ignoreHidden and child:IsShown()) or not ignoreHidden then

            local top = child:GetTop()
            local bottom = child:GetBottom();
            
            if top > maxTop then
                maxTop = top
            end
            if bottom < minBottom then
                minBottom = bottom
            end
        end
    end

    frame:SetHeight(math.abs(maxTop - minBottom));
end

LibRu.FitFrameHeightToContent = LibRu.FitFrameHeightToContent or FitFrameHeightToContent;