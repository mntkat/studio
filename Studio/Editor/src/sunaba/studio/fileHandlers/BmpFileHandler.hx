package sunaba.studio.fileHandlers;

import sunaba.core.ByteArray;

class BmpFileHandler extends ImageFileHandler {
    public override function init() {
        super.init();
        this.extension = "bmp";
    }

    public override function loadImage(image:Image, bytes:ByteArray):Error {
        return image.loadBmpFromBuffer(bytes);
    }
}