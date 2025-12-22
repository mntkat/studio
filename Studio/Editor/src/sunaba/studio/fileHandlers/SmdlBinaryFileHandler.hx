package sunaba.studio.fileHandlers;

import sunaba.studio.explorer.FileHandler;

class SmdlBinaryFileHandler extends FileHandler {
    public override function init() {
        this.extension = "smdl.dat";
        this.iconPath = "studio://icons/16/block.png";
    }

    public override function openFile(path: String) {
        var assetPath = StringTools.replace(path, explorer.assetsDirectory, editor.projectIo.pathUrl);

        var sceneEditor = new SceneEditor(editor, EditorArea.workspace);
        editor.setWorkspaceTabIcon(sceneEditor, explorer.loadIcon(iconPath));

        sceneEditor.openPrefab(assetPath.substr(0, assetPath.length - 4));
    }
}