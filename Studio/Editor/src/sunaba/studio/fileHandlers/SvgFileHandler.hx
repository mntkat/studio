package sunaba.studio.fileHandlers;

import sunaba.core.ByteArray;

class SvgFileHandler extends ImageFileHandler {
    public override function init() {
        super.init();
        this.extension = "svg";
    }

    public override function loadImage(image:Image, bytes:ByteArray):Error {
        return image.loadSvgFromBuffer(bytes);
    }
}