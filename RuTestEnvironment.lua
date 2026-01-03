---@class LibRu : Library
local LibRu = _G["LibRu"];

if not LibRu then
    error("LibRu is required for this addon, please make sure the files are present or reinstall the addon.")
end

-- Initialize global namespace/table
RTE = RTE or CreateFrame("Frame");
RTE.addonPath = "Interface\\AddOns\\RuTestEnvironment"

-- Slashcommand creation
SLASH_RU_TEST_ENVIRONMENT1 = "/RuTestEnvironment";
SLASH_RU_TEST_ENVIRONMENT2 = "/RTE";

local function PookieTestEnvironmentSlashcommandHandler(msg)
    -- Split input into words (command + args)
    local args = {}
    for word in string.gmatch(msg, "%S+") do
        table.insert(args, word)
    end

    -- First argument is the command
    local command = args[1] and string.lower(args[1]) or nil

    if not command then
        print("Welcome to Ru's Test Environment! Use /RTE help for a list of commands.")
        return
    end

    if command == "help" then
        print("Available Commands:")
        print("/RTE help - Show this help message.")
        print("/RTE debug_panel - Open a debug panel with commonly used debug features.")
        print("/RTE backdrop_templates - Open the backdrop templates frame.")
        print("/RTE collapsible_panels - Open the collapsible panels frame.")
        print("/RTE set_tad_width <width> - Set width of TableAttributeDisplay.")
    elseif command == "debug_panel" then
        if RTE.DebugPanel then
            RTE.DebugPanel:Show()
        else
            print("Could not find RTE.DebugPanel")
        end
    elseif command == "backdrop_templates" then
        if RTE.f_backdropTemplates then
            RTE.f_backdropTemplates:Show()
        else
            print("Could not find RTE.f_backdropTemplates")
        end

    elseif command == "collapsible_panels" then
        if RTE.f_collapsiblePanels then
            RTE.f_collapsiblePanels:Show()
        else
            print("Could not find RTE.f_collapsiblePanels")
        end

    elseif command == "set_tad_width" then
        local width = tonumber(args[2])
        if width then
            print("Setting TableAttributeDisplay width to:", width)
            LibRu.Debug.SetTableAttributeDisplayWidth(width)
        else
            print("Usage: /RTE set_table_attribute_display_width <number>")
        end

    else
        print("Unknown command. Type /RTE help for options.")
    end
end


-- Register commandhandler
SlashCmdList["RU_TEST_ENVIRONMENT"] = PookieTestEnvironmentSlashcommandHandler;
