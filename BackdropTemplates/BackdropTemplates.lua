local backdropTemplates = {
    "BACKDROP_ACHIEVEMENTS_0_64",
    "BACKDROP_ARENA_32_32",
    "BACKDROP_DIALOG_32_32",
    "BACKDROP_DARK_DIALOG_32_32",
    "BACKDROP_DIALOG_EDGE_32",
    "BACKDROP_GOLD_DIALOG_32_32",
    "BACKDROP_WATERMARK_DIALOG_0_16",
    "BACKDROP_SLIDER_8_8",
    "BACKDROP_PARTY_32_32",
    "BACKDROP_TOAST_12_12",
    "BACKDROP_CALLOUT_GLOW_0_16",
    "BACKDROP_CALLOUT_GLOW_0_20",
    "BACKDROP_TEXT_PANEL_0_16",
    "BACKDROP_CHARACTER_CREATE_TOOLTIP_32_32",
    "BACKDROP_WRATH_CHARACTER_CREATE_TOOLTIP_32_32",
    "BACKDROP_TUTORIAL_16_16"
}

local activeBackdrop = nil;

local function setActiveBackdrop(newBackdrop)
    if newBackdrop == activeBackdrop then
       return; 
    end

    -- update backdrop
    activeBackdrop = newBackdrop;
    RTE.f_backdropTemplates.fs_currentBackdrop:SetText(activeBackdrop)
    UIDropDownMenu_SetText(RTE.f_backdropTemplates.f_backdropSelectMenu, activeBackdrop);

    RTE.f_backdropTemplates.backdropInfo = _G[activeBackdrop];
    RTE.f_backdropTemplates:ApplyBackdrop();
end



-- main frame setup
RTE.f_backdropTemplates = CreateFrame("Frame", nil, UIParent, "BackdropTemplate");
local f_main = RTE.f_backdropTemplates;

f_main:Hide(); -- only show when asked
f_main:SetMovable(true);
f_main:SetResizable(true);
f_main:EnableMouse(true);
f_main:SetClampedToScreen(true);
f_main:SetSize(500, 600);
f_main:SetResizeBounds(500, 200);
f_main:SetPoint("CENTER");

-- apply random backdrop template


-- title text
f_main.fs_Title = f_main:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
f_main.fs_Title:SetPoint("TOP", 0, -20);
f_main.fs_Title:SetText("Frame backdrop tester");

-- current backdrop text
f_main.fs_currentBackdrop = f_main:CreateFontString(nil, "OVERLAY", "GameFontNormal");
f_main.fs_currentBackdrop:SetPoint("TOP", f_main.fs_Title, "BOTTOM", 0, -20);

-- movability of the frame
f_main:SetScript("OnMouseDown", function()
    f_main:StartMoving();
end)

f_main:SetScript("OnMouseUp", function()
    f_main:StopMovingOrSizing();
end)


-- backdrop select menu creation
f_main.f_backdropSelectMenu = CreateFrame("Frame", nil, f_main, "UIDropDownMenuTemplate");
f_main.f_backdropSelectMenu:SetPoint("TOP", f_main.fs_currentBackdrop, "BOTTOM", 0, -20);

-- backdrop select menu functionality
function f_main.f_backdropSelectMenu:OnValueSelected(newValue)
    setActiveBackdrop(newValue);
end

function f_main.f_backdropSelectMenu:LoadMenuItems()
    local info = UIDropDownMenu_CreateInfo();

    for i = 1, #backdropTemplates do
        info.text = backdropTemplates[i];
        info.arg1 = backdropTemplates[i];
        info.func = f_main.f_backdropSelectMenu.OnValueSelected;
        UIDropDownMenu_AddButton(info);
    end;

end

UIDropDownMenu_Initialize(f_main.f_backdropSelectMenu, f_main.f_backdropSelectMenu.LoadMenuItems);
UIDropDownMenu_SetWidth(f_main.f_backdropSelectMenu, 300);


-- close button
f_main.btn_close = CreateFrame("Button", nil, f_main, "UIPanelCloseButton");
f_main.btn_close:SetSize(20,20);
f_main.btn_close:SetPoint("TOPRIGHT")
f_main.btn_close:SetScript("OnClick", function()
    f_main:Hide();
end) 

-- resize button

f_main.btn_resize = LibRu.CreateResizeButton(f_main, f_main);

-- call backdrop changed once when ready setting everything up
setActiveBackdrop(backdropTemplates[math.random(1, #backdropTemplates)]);

