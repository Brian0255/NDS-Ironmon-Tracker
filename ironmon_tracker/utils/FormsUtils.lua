FormsUtils = {}

FormsUtils.POPUP_DIALOG_TYPES = {
    WARNING = "Error",
    INFO = "Info"
}

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

function FormsUtils.getCurrentDirectory()
    return io.popen "cd":read "*l"
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
