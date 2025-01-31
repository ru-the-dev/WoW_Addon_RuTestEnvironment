--[[
    TODO: document
]]
LibRu.CreateCollapsiblePanel = LibRu.CreateCollapsiblePanel or 
function (parent)
    -- create the main panel, height of this panel will dynamically be calculated and set according to its contents
    local f_panel = LibRu.Frame:New("Frame", nil, parent);
    f_panel:SetPoint("TOPLEFT");
    f_panel:SetPoint("TOPRIGHT");
    f_panel:SetHeight(1);
    f_panel.isCollapsed = false;

    -- Create header panel, this will contain the button to collapse and uncollapse the content
    local f_header = LibRu.Frame:New("Button", nil, f_panel, "UIPanelButtonTemplate");
    f_panel.f_header = f_header;
    f_header:ClearAllPoints();
    f_header:SetPoint("TOPLEFT");
    f_header:SetPoint("TOPRIGHT");
    f_header:SetText("Header");
    f_header:SetHeight(25);
    f_header.heightMode = "manual";
    
    -- Create Content frame
    local f_vLayout = LibRu.VerticalLayoutFrame:New(f_panel, nil);
    f_vLayout:ClearAllPoints();
    f_vLayout:SetPoint("TOPLEFT", f_header, "BOTTOMLEFT", 50, 0);
    f_vLayout:SetPoint("TOPRIGHT", f_header, "BOTTOMRIGHT");
    f_vLayout:SetHeight(1)
    f_panel.f_vLayout = f_vLayout;

    return f_panel;
end