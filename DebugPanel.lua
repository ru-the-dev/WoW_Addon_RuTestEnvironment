local RTE = _G["RTE"];


--- @type LibRu
local LibRu = _G["LibRu"];

if not LibRu then
    error("LibRu is required to initialize DebugPanel. Please ensure LibRu is loaded before DebugPanel.lua")
end

local debugFrame = CreateFrame("Frame", "RTE Debug Frame", UIParent, "BackdropTemplate");
debugFrame:SetBackdrop(_G["BACKDROP_TUTORIAL_16_16"]);
debugFrame:SetSize(400, 300);
debugFrame:SetPoint("BOTTOMRIGHT");
debugFrame:EnableMouse(true);

debugFrame:SetMovable(true);
-- movability of the frame
debugFrame:SetScript("OnMouseDown", function()
    debugFrame:StartMoving();
end)

debugFrame:SetScript("OnMouseUp", function()
    debugFrame:StopMovingOrSizing();
end)


-- add resize button
debugFrame.ResizeButton = LibRu.Frames.ResizeButton.New(debugFrame, debugFrame, 16)

-- close button
debugFrame.CloseButton = CreateFrame("Button", nil, debugFrame, "UIPanelCloseButton");
debugFrame.CloseButton:SetSize(20, 20);
debugFrame.CloseButton:SetPoint("TOPRIGHT")
debugFrame.CloseButton:SetScript("OnClick", function()
    debugFrame:Hide();
end)

-- title text
debugFrame.TitleLabel = debugFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
debugFrame.TitleLabel:SetPoint("TOP", 0, -20);
debugFrame.TitleLabel:SetText("Ru Test Environment - Debug Panel");


-- add fstack toggle 
debugFrame.FrameStackToggle = CreateFrame("CheckButton", "RTE Debug Frame FStack Toggle", debugFrame, "UICheckButtonTemplate");
debugFrame.FrameStackToggle:SetPoint("TOPLEFT", debugFrame, "TOPLEFT", 25, -70);
debugFrame.FrameStackToggle.Text:SetText("Toggle Frame Stack");
debugFrame.FrameStackToggle:SetScript("OnClick", function(self)
    -- Load Blizzard_DebugTools if needed
    if C_AddOns and C_AddOns.LoadAddOn then
        C_AddOns.LoadAddOn("Blizzard_DebugTools")
    end

    -- Toggle Frame Stack
    if FrameStackTooltip_Toggle then
        FrameStackTooltip_Toggle()
        -- Sync checkbox state
        if C_Timer and C_Timer.After then
            C_Timer.After(0, function()
                if _G.FrameStackTooltip then
                    self:SetChecked(_G.FrameStackTooltip:IsShown())
                end
            end)
        end
    else
        print("FrameStackTooltip_Toggle not available. Ensure Blizzard_DebugTools is enabled.")
    end
end)



-- add table attribute display width setter
debugFrame.TADWidthLabel = debugFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
debugFrame.TADWidthLabel:SetPoint("TOPLEFT", debugFrame, "TOPLEFT", 25, -110);
debugFrame.TADWidthLabel:SetText("Set TableAttributeDisplay Width:");
debugFrame.TADWidthInput = CreateFrame("EditBox", "RTE Debug Frame TAD Width Input", debugFrame, "InputBoxTemplate");
debugFrame.TADWidthInput:SetSize(100, 30);
debugFrame.TADWidthInput:SetPoint("TOPLEFT", debugFrame.TADWidthLabel, "BOTTOMLEFT", 0, -10);
debugFrame.TADWidthInput:SetAutoFocus(false);
debugFrame.TADWidthInput:SetNumeric(true);
debugFrame.TADWidthInput:SetScript("OnEnterPressed", function(self)
    local width = tonumber(self:GetText());
    if width then
        print("Setting TableAttributeDisplay width to:", width)
        LibRu.Debug.SetTableAttributeDisplayWidth(width);
    else
        print("Invalid width input. Please enter a valid number.");
    end
    self:ClearFocus();
end);

-- add table attribute display height setter
debugFrame.TADHeightLabel = debugFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
debugFrame.TADHeightLabel:SetPoint("TOPLEFT", debugFrame.TADWidthInput, "BOTTOMLEFT", 0, -10);
debugFrame.TADHeightLabel:SetText("Set TableAttributeDisplay Height:");
debugFrame.TADHeightInput = CreateFrame("EditBox", "RTE Debug Frame TAD Height Input", debugFrame, "InputBoxTemplate");
debugFrame.TADHeightInput:SetSize(100, 30);
debugFrame.TADHeightInput:SetPoint("TOPLEFT", debugFrame.TADHeightLabel, "BOTTOMLEFT", 0, -10);
debugFrame.TADHeightInput:SetAutoFocus(false);
debugFrame.TADHeightInput:SetNumeric(true);
debugFrame.TADHeightInput:SetScript("OnEnterPressed", function(self)
    local height = tonumber(self:GetText());
    if height then
        print("Setting TableAttributeDisplay height to:", height)
        LibRu.Debug.SetTableAttributeDisplayHeight(height);
    else
        print("Invalid height input. Please enter a valid number.");
    end
    self:ClearFocus();
end);

-- reload UI button
debugFrame.ReloadUIButton = CreateFrame("Button", "RTE Debug Frame Reload UI", debugFrame, "UIPanelButtonTemplate");
debugFrame.ReloadUIButton:SetSize(120, 25);
debugFrame.ReloadUIButton:SetPoint("TOPLEFT", debugFrame.TADHeightInput, "BOTTOMLEFT", -10, -10);
debugFrame.ReloadUIButton:SetText("Reload UI");
debugFrame.ReloadUIButton:SetScript("OnClick", function()
    ReloadUI();
end);


RTE.DebugPanel = debugFrame;