package sunaba.studio.fileHandlers;

import sunaba.core.ByteArray;

class WebpFileHandler extends ImageFileHandler {
    public override function init() {
        super.init();
        this.extension = "webp";
    }

    public override function loadImage(image:Image, bytes:ByteArray):Error {
        return image.loadWebpFromBuffer(bytes);
    }
}