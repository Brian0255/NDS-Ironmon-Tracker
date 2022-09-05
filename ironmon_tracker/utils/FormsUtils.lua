FormsUtils = {}

FormsUtils.POPUP_DIALOG_TYPES = {
    WARNING = "!",
    INFO = "Info"
}

function FormsUtils.popupDialog(info, x, y, width, height, dialogType)
    local infoForm =
        forms.newform(
        width,
        height,
        dialogType,
        function()
        end
    )
    forms.setlocation(infoForm, x, y)
    local canvas = forms.pictureBox(infoForm, 0, 0, width, height)
    forms.drawText(canvas, 10, 10, info, 0xFF000000, 0x00000000, 14, "Arial")
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

function FormsUtils.getCenter(width, height)
    return {
    xPos = client.xpos() + client.screenwidth() / 2 - width / 2,
     yPos = client.ypos() + client.screenheight() / 2 - height / 2
    }
end
