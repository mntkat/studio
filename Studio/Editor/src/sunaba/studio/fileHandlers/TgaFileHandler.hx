package sunaba.studio.fileHandlers;

import sunaba.core.ByteArray;

class TgaFileHandler extends ImageFileHandler {
    public override function init() {
        super.init();
        this.extension = "tga";
    }

    public override function loadImage(image:Image, bytes:ByteArray):Error {
        return image.loadTgaFromBuffer(bytes);
    }
}