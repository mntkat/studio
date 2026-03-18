package sunaba.studio.fileHandlers;

import sunaba.core.ByteArray;

class JpegFileHandler extends ImageFileHandler {
    public override function init() {
        super.init();
        this.extension = "jpeg";
    }

    public override function loadImage(image:Image, bytes:ByteArray):Error {
        return image.loadJpgFromBuffer(bytes);
    }
}