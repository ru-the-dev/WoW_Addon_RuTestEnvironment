-- create main frame
local f_main = CreateFrame("Frame", nil, UIParent) --local var for easier access
RTE.f_collapsiblePanels = f_main;

-- main frame setup
-- f_main:Hide(); -- Only show when asked
f_main:SetMovable(true);
f_main:SetClampedToScreen(true);
f_main:SetSize(500,200);
f_main:SetResizeBounds(300, 300);
f_main:SetPoint("RIGHT");

f_main.t_background = LibRu.CreateSlicedTexture(f_main, RTE.addonPath .. "\\Assets\\PeterodoxTooltipBackground.png", 32, 32, 32, 32);

-- create inset frame (padding for main frame)
local f_mainInset = LibRu.CreateInsetFrame("Frame", nil, f_main, "BackdropTemplate", 8);
f_main.f_inset = f_mainInset;


-- movability of the main frame
f_main:SetScript("OnMouseDown", function()
    f_main:StartMoving();
end)

f_main:SetScript("OnMouseUp", function()
    f_main:StopMovingOrSizing();
end)

-- close button
f_mainInset.btn_close = CreateFrame("Button", nil, f_mainInset, "UIPanelCloseButton");
f_mainInset.btn_close:SetSize(20,20);
f_mainInset.btn_close:SetPoint("TOPRIGHT")
f_mainInset.btn_close:SetScript("OnClick", function()
    f_main:Hide();
end) 

-- resize button
f_mainInset.btn_resize = LibRu.CreateResizeButton(f_mainInset, f_main);


-- -- START OF PANEL 1
-- -- title button
-- local btn_panel1Header = CreateFrame("Button", nil, f_mainInset, "UIPanelButtonTemplate");
-- f_mainInset.btn_panel1Header = btn_panel1Header;
-- btn_panel1Header:SetSize(180,20);
-- btn_panel1Header:SetPoint("TOP", f_mainInset, "TOP");
-- btn_panel1Header:SetText("Panel 1 Title");

-- -- create a frame to hold the panel 1 elements
-- btn_panel1Header.f_panelContents = CreateFrame("Frame", nil, btn_panel1Header);
-- btn_panel1Header.f_panelContents:SetPoint("TOP", btn_panel1Header, "BOTTOM", 0, -5)
-- btn_panel1Header.f_panelContents:SetPoint("LEFT")
-- btn_panel1Header.f_panelContents:SetPoint("RIGHT")
-- btn_panel1Header.f_panelContents:SetHeight(100);
-- btn_panel1Header.isCollapsed = false;

-- local tempTexture = btn_panel1Header.f_panelContents:CreateTexture(nil, "BACKGROUND")
-- tempTexture:SetAllPoints();
-- tempTexture:SetColorTexture(1, 0, 0, 1);

-- -- create the elements
-- btn_panel1Header.f_panelContents.contents = {};

-- local element = btn_panel1Header.f_panelContents:CreateFontString(nil, "OVERLAY", "GameFontNormal")
-- element:SetText("Element 1")
-- element:SetPoint("TOPLEFT")
-- element:SetPoint("TOPRIGHT");
-- element:SetHeight(25);

-- table.insert(btn_panel1Header.f_panelContents.contents, element);


-- btn_panel1Header:SetScript("OnClick", function ()
--     btn_panel1Header.isCollapsed = not btn_panel1Header.isCollapsed;
--     if btn_panel1Header.isCollapsed then
--         btn_panel1Header.f_panelContents:Hide();
--         btn_panel1Header.f_panelContents:SetHeight(0);
--     else
--         btn_panel1Header.f_panelContents:Show();
--         btn_panel1Header.f_panelContents:SetHeight(100);
--     end
-- end);


local f_mainVerticalLayout = LibRu.VerticalLayoutFrame:New(f_mainInset);
f_mainVerticalLayout:SetPoint("TOPRIGHT");
f_mainVerticalLayout:SetPoint("TOPLEFT");
f_mainVerticalLayout:SetHeight(1); -- temp height, will auto fit later
f_mainInset.f_layout = f_mainVerticalLayout;


-- create zone panel
local zone1 = LibRu.CreateCollapsiblePanel(f_mainVerticalLayout)
zone1.f_header:SetText("Zone 1")
zone1.orderIndex = 1;

-- create vendor 1 panel
local vendor1 = LibRu.CreateCollapsiblePanel(zone1.f_vLayout)
vendor1.f_header:SetText("Vendor 1")

-- create item 1 panel
vendor1.item1 = LibRu.CreateCollapsiblePanel(vendor1.f_vLayout)
vendor1.item1.f_header:SetText("Item 1")

-- create cost 1 text
vendor1.item1.f_vLayout.cost1 = vendor1.item1.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor1.item1.f_vLayout.cost1:SetText("Cost 1")
vendor1.item1.f_vLayout.cost1.orderIndex = 1;
vendor1.item1.f_vLayout.cost1:SetHeight(25);
vendor1.item1.f_vLayout.cost1:SetJustifyH("LEFT");

-- create cost 2 text
vendor1.item1.f_vLayout.cost1 = vendor1.item1.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor1.item1.f_vLayout.cost1:SetText("Cost 2")
vendor1.item1.f_vLayout.cost1.orderIndex = 1;
vendor1.item1.f_vLayout.cost1:SetHeight(25);
vendor1.item1.f_vLayout.cost1:SetJustifyH("LEFT");

vendor1.item1.f_vLayout:ApplyLayout();



-- create item 2 panel
vendor1.item2 = LibRu.CreateCollapsiblePanel(vendor1.f_vLayout)
vendor1.item2.f_header:SetText("Item 2")

-- create cost 1 text
vendor1.item2.f_vLayout.cost1 = vendor1.item2.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor1.item2.f_vLayout.cost1:SetText("Cost 1")
vendor1.item2.f_vLayout.cost1.orderIndex = 1;
vendor1.item2.f_vLayout.cost1:SetHeight(25);
vendor1.item2.f_vLayout.cost1:SetJustifyH("LEFT");

-- create cost 2 text
vendor1.item2.f_vLayout.cost1 = vendor1.item2.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor1.item2.f_vLayout.cost1:SetText("Cost 2")
vendor1.item2.f_vLayout.cost1.orderIndex = 1;
vendor1.item2.f_vLayout.cost1:SetHeight(25);
vendor1.item2.f_vLayout.cost1:SetJustifyH("LEFT");

vendor1.item2.f_vLayout:ApplyLayout();


-- create vendor 1 total cost panel
vendor1.totalCost = LibRu.CreateCollapsiblePanel(vendor1.f_vLayout)
vendor1.totalCost.f_header:SetText("Vendor 1 Total Cost: ")

-- create cost 1 text
vendor1.totalCost.f_vLayout.cost1 = vendor1.totalCost.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor1.totalCost.f_vLayout.cost1:SetText("Cost 1")
vendor1.totalCost.f_vLayout.cost1.orderIndex = 1;
vendor1.totalCost.f_vLayout.cost1:SetHeight(25);
vendor1.totalCost.f_vLayout.cost1:SetJustifyH("LEFT");

-- create cost 2 text
vendor1.totalCost.f_vLayout.cost1 = vendor1.totalCost.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor1.totalCost.f_vLayout.cost1:SetText("Cost 2")
vendor1.totalCost.f_vLayout.cost1.orderIndex = 1;
vendor1.totalCost.f_vLayout.cost1:SetHeight(25);
vendor1.totalCost.f_vLayout.cost1:SetJustifyH("LEFT");

vendor1.totalCost.f_vLayout:ApplyLayout();

vendor1.f_vLayout:ApplyLayout();

-- create vendor 2 panel
local vendor2 = LibRu.CreateCollapsiblePanel(zone1.f_vLayout)
vendor2.f_header:SetText("Vendor 2")

-- create item 1 panel
vendor2.item1 = LibRu.CreateCollapsiblePanel(vendor2.f_vLayout)
vendor2.item1.f_header:SetText("Item 1")

-- create cost 1 text
vendor2.item1.f_vLayout.cost1 = vendor2.item1.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor2.item1.f_vLayout.cost1:SetText("Cost 1")
vendor2.item1.f_vLayout.cost1.orderIndex = 1;
vendor2.item1.f_vLayout.cost1:SetHeight(25);
vendor2.item1.f_vLayout.cost1:SetJustifyH("LEFT");

-- create cost 2 text
vendor2.item1.f_vLayout.cost1 = vendor2.item1.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor2.item1.f_vLayout.cost1:SetText("Cost 2")
vendor2.item1.f_vLayout.cost1.orderIndex = 1;
vendor2.item1.f_vLayout.cost1:SetHeight(25);
vendor2.item1.f_vLayout.cost1:SetJustifyH("LEFT");

vendor2.item1.f_vLayout:ApplyLayout();



-- create item 2 panel
vendor2.item2 = LibRu.CreateCollapsiblePanel(vendor2.f_vLayout)
vendor2.item2.f_header:SetText("Item 2")

-- create cost 1 text
vendor2.item2.f_vLayout.cost1 = vendor2.item2.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor2.item2.f_vLayout.cost1:SetText("Cost 1")
vendor2.item2.f_vLayout.cost1.orderIndex = 1;
vendor2.item2.f_vLayout.cost1:SetHeight(25);
vendor2.item2.f_vLayout.cost1:SetJustifyH("LEFT");

-- create cost 2 text
vendor2.item2.f_vLayout.cost1 = vendor2.item2.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor2.item2.f_vLayout.cost1:SetText("Cost 2")
vendor2.item2.f_vLayout.cost1.orderIndex = 1;
vendor2.item2.f_vLayout.cost1:SetHeight(25);
vendor2.item2.f_vLayout.cost1:SetJustifyH("LEFT");

vendor2.item2.f_vLayout:ApplyLayout();


-- create vendor 1 total cost panel
vendor2.totalCost = LibRu.CreateCollapsiblePanel(vendor2.f_vLayout)
vendor2.totalCost.f_header:SetText("Vendor 2 Total Cost: ")

-- create cost 1 text
vendor2.totalCost.f_vLayout.cost1 = vendor2.totalCost.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor2.totalCost.f_vLayout.cost1:SetText("Cost 1")
vendor2.totalCost.f_vLayout.cost1.orderIndex = 1;
vendor2.totalCost.f_vLayout.cost1:SetHeight(25);
vendor2.totalCost.f_vLayout.cost1:SetJustifyH("LEFT");

-- create cost 2 text
vendor2.totalCost.f_vLayout.cost1 = vendor2.totalCost.f_vLayout:CreateFontString(nil, "OVERLAY", "GameFontNormal");
vendor2.totalCost.f_vLayout.cost1:SetText("Cost 2")
vendor2.totalCost.f_vLayout.cost1.orderIndex = 1;
vendor2.totalCost.f_vLayout.cost1:SetHeight(25);
vendor2.totalCost.f_vLayout.cost1:SetJustifyH("LEFT");

vendor2.totalCost.f_vLayout:ApplyLayout();

vendor2.f_vLayout:ApplyLayout();

zone1.f_vLayout:ApplyLayout();

f_mainVerticalLayout:ApplyLayout();
--LibRu.FitFrameHeightToContent(f_mainVerticalLayout);
f_mainVerticalLayout:FitHeightToContent(true);

--TODO for next time:
-- Figure out why f_mainInset.f_layout height is 1
-- figure out collapsiblePanel1 height is 1
