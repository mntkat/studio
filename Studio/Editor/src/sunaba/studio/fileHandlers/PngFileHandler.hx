package sunaba.studio.fileHandlers;

import sunaba.core.ByteArray;

class PngFileHandler extends ImageFileHandler {
    public override function init() {
        super.init();
        this.extension = "png";
    }

    public override function loadImage(image:Image, bytes:ByteArray):Error {
        return image.loadPngFromBuffer(bytes);
    }
}