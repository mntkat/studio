package sunaba.studio.fileHandlers;

import sunaba.core.ByteArray;

class KtxFileHandler extends ImageFileHandler {
    public override function init() {
        super.init();
        this.extension = "ktx";
    }

    public override function loadImage(image:Image, bytes:ByteArray):Error {
        return image.loadKtxFromBuffer(bytes);
    }
}