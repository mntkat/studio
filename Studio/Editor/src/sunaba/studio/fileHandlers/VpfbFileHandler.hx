package sunaba.studio.fileHandlers;

import sunaba.studio.explorer.FileHandler;

class VpfbFileHandler extends FileHandler {
    public override function init() {
        this.extension = "vpfb";
        this.iconPath = "studio://icons/16/block.png";
    }
}