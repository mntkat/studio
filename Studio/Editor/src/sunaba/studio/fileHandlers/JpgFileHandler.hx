package sunaba.studio.fileHandlers;

import sunaba.core.ByteArray;

class JpgFileHandler extends ImageFileHandler {
    public override function init() {
        super.init();
        this.extension = "jpg";
    }

    public override function loadImage(image:Image, bytes:ByteArray):Error {
        return image.loadJpgFromBuffer(bytes);
    }
}