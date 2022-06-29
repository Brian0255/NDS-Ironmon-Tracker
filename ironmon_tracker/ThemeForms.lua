ThemeForms = {
    SAVE_THEME_WIDTH = 288,
    SAVE_THEME_HEIGHT = 70,
    EXPORT_THEME_WIDTH = 730,
    EXPORT_THEME_HEIGHT = 70,
    IMPORT_THEME_WIDTH = 780,
    IMPORT_THEME_HEIGHT = 70,
    CENTER_X = client.xpos() + client.screenwidth() / 2,
    CENTER_Y = client.ypos() + client.screenheight() / 2,
    THEMES_PATH = DATA_FOLDER.."/themes",
}



function ThemeForms.createSaveThemeForm()
    Input.dialogActive = true
    local saveForm = forms.newform(ThemeForms.SAVE_THEME_WIDTH,ThemeForms.SAVE_THEME_HEIGHT,"Save theme",function() Input.dialogActive = false  end)
    forms.setlocation(saveForm,ThemeForms.CENTER_X-ThemeForms.SAVE_THEME_WIDTH/2,ThemeForms.CENTER_Y-ThemeForms.SAVE_THEME_HEIGHT/2)
    local canvas = forms.pictureBox(saveForm,0,0,100,30)
    local fileName = forms.textbox(saveForm,nil,100,30,nil,100,5)
    local saveButton = forms.button(saveForm,"Save",function()end ,206,3,60,24)
    forms.addclick(saveButton,function() ThemeForms.onSaveThemeClick(fileName) end)
    forms.drawText(canvas,6,7,"Theme name:",0xFF000000,0x00000000,14,"Arial")
    
end

function ThemeForms.onImportThemeClick(text)
    GraphicConstants.readThemeString(text)
    ColorOptions.redraw = true
end

function ThemeForms.onSaveThemeClick(fileNameTextbox)
    local text = forms.gettext(fileNameTextbox)
    if text ~= "" then
        local savePath = ThemeForms.THEMES_PATH.."/"..text..".colortheme"
        if not Utils.fileExists(savePath) then
            local file = io.open(savePath,"w")
            ThemeForms.saveFile(file)
        else
            local file = io.open(savePath,"w")
            ThemeForms.createSaveConfirmDialog(ThemeForms.CENTER_X-ThemeForms.SAVE_THEME_WIDTH/2,ThemeForms.CENTER_Y-ThemeForms.SAVE_THEME_HEIGHT/2,ThemeForms.SAVE_THEME_WIDTH,130,file)
        end
    end
end

function ThemeForms.saveFile(file)
    io.output(file)
    local settingsString = GraphicConstants.getThemeString()
    io.write(settingsString)
    forms.destroyall()
    Input.dialogActive = false
    Utils.popupDialog("File successfully saved.",ThemeForms.CENTER_X-ThemeForms.SAVE_THEME_WIDTH/2,ThemeForms.CENTER_Y-ThemeForms.SAVE_THEME_HEIGHT/2,
    ThemeForms.SAVE_THEME_WIDTH,78,Utils.POPUP_DIALOG_TYPES.INFO)
    io.close(file)
end

function ThemeForms.createSaveConfirmDialog(x,y,width,height,file)
    local confirmForm = forms.newform(width,height,"Confirm")
	forms.setlocation(confirmForm,x,y)
	local canvas = forms.pictureBox(confirmForm,0,0,width,52)

	forms.drawText(canvas,16,10,"A theme with this name already exists.",0xFF000000,0x00000000,14,"Arial")
    forms.drawText(canvas,50,32,"Do you want to replace it?",0xFF000000,0x00000000,14,"Arial")

    local confirmButton = forms.button(confirmForm,"Yes",function()end ,72,height-74,60,24)
    forms.addclick(confirmButton,function() ThemeForms.saveFile(file) end)

    forms.button(confirmForm,"Cancel",
    function() 
        io.close(file) 
        Input.dialogActive = false 
        forms.destroy(confirmForm)
    end, 
    138,height-74,60,24)
end

function ThemeForms.createDefaultConfirmDialog()
    local x,y = ThemeForms.CENTER_X-ThemeForms.SAVE_THEME_WIDTH/2,ThemeForms.CENTER_Y-ThemeForms.SAVE_THEME_HEIGHT/2
    local width,height = ThemeForms.SAVE_THEME_WIDTH,130
    local confirmForm = forms.newform(width,height,"Confirm", 
    function()
        Input.dialogActive = false
    end
    )
	forms.setlocation(confirmForm,x,y)
	local canvas = forms.pictureBox(confirmForm,0,0,width,52)

	forms.drawText(canvas,40,10,"This action cannot be undone.",0xFF000000,0x00000000,14,"Arial")
    forms.drawText(canvas,90,32,"Are you sure?",0xFF000000,0x00000000,14,"Arial")

    local confirmButton = forms.button(confirmForm,"Yes",function() end ,72,height-74,60,24)

    forms.addclick(confirmButton,function() 
        forms.destroy(confirmForm)
        Input.dialogActive = false 
        GraphicConstants.restoreDefaults()
        ColorOptions.redraw = true
        GraphicConstants.saveSettings()
    end)

    forms.button(confirmForm,"Cancel",
    function() 
        Input.dialogActive = false 
        forms.destroy(confirmForm)
    end, 
    138,height-74,60,24)
end

function ThemeForms.createLoadThemeForm()
    local current_dir=io.popen"cd":read'*l'
    local ending = ".colortheme"
    local themeFile = forms.openfile("*"..ending,current_dir.."\\ironmon_tracker\\themes")
    local start = #themeFile-#ending
    if #themeFile > #ending and string.sub(themeFile,start+1) == ending then
        themeFile = io.open(themeFile,"r")
        if themeFile ~= nil then
            local themeString = themeFile:read "*a"
            GraphicConstants.readThemeString(themeString)
            ColorOptions.redraw = true
        else
            Utils.popupDialog("Invalid file selection.",ThemeForms.CENTER_X-ThemeForms.SAVE_THEME_WIDTH/2,ThemeForms.CENTER_Y-ThemeForms.SAVE_THEME_HEIGHT/2,
            ThemeForms.SAVE_THEME_WIDTH,78,Utils.POPUP_DIALOG_TYPES.INFO)
        end
    end
end

function ThemeForms.createImportThemeForm()
    Input.dialogActive = true
    local importForm = forms.newform(ThemeForms.IMPORT_THEME_WIDTH,ThemeForms.IMPORT_THEME_HEIGHT,"Import theme string",function() Input.dialogActive = false end)
    forms.setlocation(importForm,ThemeForms.CENTER_X-ThemeForms.IMPORT_THEME_WIDTH/2,ThemeForms.CENTER_Y-ThemeForms.IMPORT_THEME_HEIGHT/2)
    local canvas = forms.pictureBox(importForm,0,0,90,30)
    local stringBox = forms.textbox(importForm,nil,ThemeForms.IMPORT_THEME_WIDTH-190,30,nil,100,5)
    local importButton = forms.button(importForm,"Import",function() ThemeForms.onImportThemeClick(forms.gettext(stringBox)) end ,ThemeForms.IMPORT_THEME_WIDTH-84,3,60,24)
    forms.drawText(canvas,6,7,"Theme string:",0xFF000000,0x00000000,14,"Arial")
end


function ThemeForms.createExportThemeForm()
    Input.dialogActive = true
    local exportForm = forms.newform(ThemeForms.EXPORT_THEME_WIDTH,ThemeForms.EXPORT_THEME_HEIGHT,"Exported string (Copy and share!)",function() Input.dialogActive = false end)
    forms.setlocation(exportForm,ThemeForms.CENTER_X-ThemeForms.EXPORT_THEME_WIDTH/2,ThemeForms.CENTER_Y-ThemeForms.EXPORT_THEME_HEIGHT/2)
    local themeString = GraphicConstants.getThemeString()
    local canvas = forms.pictureBox(exportForm,0,0,100,30)
    local stringBox = forms.textbox(exportForm,themeString,ThemeForms.EXPORT_THEME_WIDTH-122,30,nil,100,5)
    forms.drawText(canvas,6,7,"Theme string:",0xFF000000,0x00000000,14,"Arial")
end
