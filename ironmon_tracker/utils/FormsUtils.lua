FormsUtils = {}

FormsUtils.POPUP_DIALOG_TYPES = {
    WARNING = "Error",
    INFO = "Info"
}

function FormsUtils.createMainScreenNote(pokemonID, note, noteSettingFunction, drawingFunction)
    local width, height = 270, 70
    local clientCenter = FormsUtils.getCenter(width, height)
    local charMax = 40
    if pokemonID ~= nil then
        forms.destroyall()
        local noteForm =
            forms.newform(
            width,
            height,
            "Note (" .. charMax .. " char. max)",
            function()
            end
        )
        local textBox = forms.textbox(noteForm, note, 190, 0, nil, 5, 5)
        forms.button(
            noteForm,
            "Set",
            function()
                noteSettingFunction(pokemonID, forms.gettext(textBox))
                drawingFunction()
                forms.destroy(noteForm)
            end,
            200,
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