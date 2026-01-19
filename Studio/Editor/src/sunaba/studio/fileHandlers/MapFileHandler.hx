package sunaba.studio.fileHandlers;

import sunaba.studio.explorer.FileHandler;
import sunaba.studio.SceneEditor;
import sunaba.studio.MapViewer;

class MapFileHandler extends FileHandler {
    public override function init() {
        this.extension = "map";
        this.iconPath = "studio://icons/16/clapperboard.png";
    }

    public override function openFile(path: String) {
        var assetPath = StringTools.replace(path, explorer.assetsDirectory, editor.projectIo.pathUrl);

        var mapViewer = new MapViewer(editor, EditorArea.workspace);
        editor.setWorkspaceTabIcon(mapViewer, explorer.loadIcon(iconPath));

        mapViewer.openMap(assetPath);
    }
}