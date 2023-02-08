FormsUtils = {}

FormsUtils.POPUP_DIALOG_TYPES = {
    WARNING = "Error",
    INFO = "Info"
}

function FormsUtils.createMainScreenNote(pokemonID, note, noteSettingFunction, drawingFunction)
    local width, height = 350, 70
    local clientCenter = FormsUtils.getCenter(width, height)
    if pokemonID ~= nil then
        forms.destroyall()
        local noteForm =
            forms.newform(
            width,
            height,
            "Note",
            function()
            end
        )
        local textBox = forms.textbox(noteForm, note, 270, 0, nil, 5, 5)
        forms.button(
            noteForm,
            "Set",
            function()
                noteSettingFunction(pokemonID, forms.gettext(textBox))
                drawingFunction()
                forms.destroy(noteForm)
            end,
            280,
            4,
            48,
            22
        )
        forms.setlocation(noteForm, clientCenter.xPos, clientCenter.yPos)
        forms.setproperty(textBox, "TabStop", true)
    end
end

function FormsUtils.popupDialog(info, width, height, dialogType, pauseUntilClosed)
    if pauseUntilClosed == nil then
        pauseUntilClosed = false
    end
    client.pause()
    local centerPosition = FormsUtils.getCenter(width,height)
    local infoForm =
        forms.newform(
        width,
        height,
        dialogType,
        function()
            client.unpause()
        end
    )
    forms.setlocation(infoForm, centerPosition.xPos, centerPosition.yPos)
    forms.label(infoForm, info, 10, 10, width-30, height-20)
end

function FormsUtils.fileExists(path)
    local file = io.open(path, "r")
    if file ~= nil then
        io.close(file)
        return true
    else
        return false
    end
end

function FormsUtils.getFileNameFromPath(path)
    return path:reverse():match("([^\\]*)\\"):reverse()
end

function FormsUtils.getCenter(width, height)
    return {
    xPos = client.xpos() + client.screenwidth() / 2 - width / 2,
     yPos = client.ypos() + client.screenheight() / 2 - height / 2
    }
end

function FormsUtils.shortenFolderName(path)
    if path ~= "" then
        local shortenedPath = path:reverse():match("([^\\]*\\)"):reverse()
        if #shortenedPath > 25 then
            shortenedPath = shortenedPath:sub(1,25).."..."
        end
        return "..."..shortenedPath
    end
end

function FormsUtils.createConfirmDialog(callback)
    forms.destroyall()
    local center = FormsUtils.getCenter(288,130)
    local x, y = center.xPos, center.yPos
    local width, height = 288, 130
    local confirmForm =
        forms.newform(
        width,
        height,
        "Confirm",
        function()
        end
    )
    forms.setlocation(confirmForm, x, y)
    local canvas = forms.pictureBox(confirmForm, 0, 0, width, 52)

    forms.drawText(canvas, 40, 10, "This action cannot be undone.", 0xFF000000, 0x00000000, 14, "Arial")
    forms.drawText(canvas, 90, 32, "Are you sure?", 0xFF000000, 0x00000000, 14, "Arial")

    local confirmButton =
        forms.button(
        confirmForm,
        "Yes",
        function()
        end,
        72,
        height - 74,
        60,
        24
    )

    forms.addclick(
        confirmButton,
        function()
            forms.destroy(confirmForm)

            callback()
        end
    )

    forms.button(
        confirmForm,
        "Cancel",
        function()
            forms.destroy(confirmForm)
        end,
        138,
        height - 74,
        60,
        24
    )
end

local function runOperation(fileSavingOperation, filePath)
    fileSavingOperation(filePath)
    forms.destroyall()
    FormsUtils.popupDialog(
        "File successfully saved.",
        288,
        78,
        FormsUtils.POPUP_DIALOG_TYPES.INFO
    )
end

local function onConfirm(fileSavingOperation, filePath)
   runOperation(fileSavingOperation, filePath)
end

local function createSaveConfirmDialog(x, y, width, height, fileSavingOperation, filePath, fileType)
    forms.destroyall()
    local confirmForm = forms.newform(width, height, "Confirm")
    forms.setlocation(confirmForm, x, y)
    local canvas = forms.pictureBox(confirmForm, 0, 0, width, 52)

    forms.drawText(canvas, 16, 10, "A "..fileType.." with this name already exists.", 0xFF000000, 0x00000000, 14, "Arial")
    forms.drawText(canvas, 50, 32, "Do you want to replace it?", 0xFF000000, 0x00000000, 14, "Arial")

    local confirmButton =
        forms.button(
        confirmForm,
        "Yes",
        function()
        end,
        72,
        height - 74,
        60,
        24
    )
    forms.addclick(
        confirmButton,
        function()
            onConfirm(fileSavingOperation, filePath)
        end
    )

    forms.button(
        confirmForm,
        "Cancel",
        function()
            forms.destroyall()
        end,
        138,
        height - 74,
        60,
        24
    )
end

local function onSaveClick(x,y,fileNameTextbox, folderPath, fileExtension, fileSavingOperation, fileType)
    local text = forms.gettext(fileNameTextbox)
    if text ~= "" then
        local savePath = folderPath.."\\" .. text .. fileExtension
        if not FormsUtils.fileExists(savePath) then
            runOperation(fileSavingOperation, savePath)
        else
            createSaveConfirmDialog(
                x,y,
                288,
                130,
                fileSavingOperation,
                savePath,
                fileType
            )
        end
    end
end

function FormsUtils.createSaveForm(folderPath, fileType, fileExtension, fileSavingOperation)
    forms.destroyall()
    local width, height = 288, 70
    local saveForm = forms.newform(width, height, "Save "..fileType)
    local center = FormsUtils.getCenter(width,height)
    forms.setlocation(
        saveForm,
        center.xPos, center.yPos
    )
    local canvas = forms.pictureBox(saveForm, 0, 0, 100, 30)
    local fileName = forms.textbox(saveForm, nil, 100, 30, nil, 100, 5)
    local saveButton =
        forms.button(
        saveForm,
        "Save",
        function()
        end,
        206,
        3,
        60,
        24
    )
    forms.addclick(
        saveButton,
        function()
            onSaveClick(center.xPos, center.yPos, fileName, folderPath, fileExtension, fileSavingOperation, fileType)
        end
    )
    local beforeName = fileType:sub(1,1):upper()..fileType:sub(2):lower()
    forms.drawText(canvas, 6, 7, beforeName.." name:", 0xFF000000, 0x00000000, 14, "Arial")
end

