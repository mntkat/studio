package sunaba.studio.fileHandlers;

import sunaba.studio.explorer.FileHandler;

class HxFileHandler extends FileHandler {
    public override function init() {
        this.extension = "hx";
        this.iconPath = "studio://icons/16/script-code.png";
    }

    public override function openFile(path: String) {
        Debug.info("Opened file: " + path);
    }
}