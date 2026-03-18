package sunaba.studio.fileHandlers;

import sunaba.core.ByteArray;

class DdsFileHandler extends ImageFileHandler {
    public override function init() {
        super.init();
        this.extension = "dds";
    }

    public override function loadImage(image:Image, bytes:ByteArray):Error {
        return image.loadDdsFromBuffer(bytes);
    }
}