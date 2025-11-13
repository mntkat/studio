package sunaba.studio;

import sunaba.ui.VSplitContainer;
import sunaba.SizeFlags;
import sunaba.core.Vector2i;
import sunaba.core.Vector2;

class SceneInspector extends EditorWidget {
    public override function editorInit() {
        getEditor().setRightSidebarTabTitle(this, "Scene Inspector");

        var iconBin = io.loadBytes("studio://icons/16_1-5x/clapperboard--pencil.png");
        var iconImage = new Image();
        iconImage.loadPngFromBuffer(iconBin);
        var texture = ImageTexture.createFromImage(iconImage);
        getEditor().setRightSiderbarTabIcon(this, texture);
        customMinimumSize = new Vector2(275, 0);

        load("studio://SceneInspector.suml");
    }
}