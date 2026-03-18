package sunaba.studio.fileHandlers;

import sunaba.core.ByteArray;
import sunaba.studio.explorer.FileHandler;


class ImageFileHandler extends FileHandler {
    public override function init() {
        this.iconPath = "studio://icons/16/image.png";
    }

    public override function openFile(path: String) {
        var realPath = editor.io.getFilePath(path);
        OSService.shellOpen(realPath);
    }

    public override function getThunbnail(path:String):Texture2D {
        var imageBytes = editor.io.loadBytes(path);
        
        var image = new Image();
        var err = loadImage(image, imageBytes);
        
        if (err != Error.ok) {
            return editor.loadIcon("studio://icons/16_2x/image.png");
        }

        var imageTexture = ImageTexture.createFromImage(image);
        return imageTexture;
    }

    public function loadImage(image: Image, bytes: ByteArray): Error {
        return Error.failed;
    }
}