-- Create a collapsible panel
local function CreateCollapsiblePanel(parent, titleText, elements, xOffset, yOffset)
    -- Main frame for the panel
    local panel = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    panel:SetSize(200, 20) -- Initial size (will grow when expanded)
    panel:SetPoint("TOPLEFT", parent, "TOPLEFT", xOffset, yOffset)
    panel:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 10,
    })
    panel:SetBackdropColor(0, 0, 0, 0.8)

    -- Title button for the panel
    local titleButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    titleButton:SetSize(180, 20)
    titleButton:SetPoint("TOP", panel, "TOP", 0, 0)
    titleButton:SetText(titleText)

    -- Create a frame to hold elements (for collapsibility)
    local contentFrame = CreateFrame("Frame", nil, panel)
    contentFrame:SetPoint("TOPLEFT", panel, "BOTTOMLEFT", 0, 0)
    contentFrame:SetSize(200, #elements * 20) -- Height depends on elements

    -- Create the elements
    local elementFrames = {}
    for i, elementText in ipairs(elements) do
        local element = contentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        element:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 10, -(i - 1) * 20)
        element:SetText(elementText)
        table.insert(elementFrames, element)
    end

    -- Toggle visibility when the title is clicked
    local isCollapsed = false
    titleButton:SetScript("OnClick", function()
        isCollapsed = not isCollapsed
        if isCollapsed then
            contentFrame:Hide()
            panel:SetHeight(20) -- Only show the title
        else
            contentFrame:Show()
            panel:SetHeight(20 + #elements * 20) -- Title + elements
        end
    end)

    -- Initially collapse the content
    contentFrame:Hide()
    return panel
end

-- Parent frame for the demo
local parentFrame = CreateFrame("Frame", "DemoParentFrame", UIParent, "BackdropTemplate")
parentFrame:SetSize(300, 400)
parentFrame:SetPoint("CENTER")
parentFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    edgeSize = 12,
})
parentFrame:SetBackdropColor(0, 0, 0, 0.8)

-- Example usage
local panel1 = CreateCollapsiblePanel(parentFrame, "Panel Title 1", {"Element 1", "Element 2", "Element 3"}, 10, -10)
local panel2 = CreateCollapsiblePanel(parentFrame, "Panel Title 2", {"Element 4", "Element 5", "Element 6"}, 10, -90)
