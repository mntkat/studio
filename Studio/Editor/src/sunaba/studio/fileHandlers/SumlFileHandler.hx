package sunaba.studio.fileHandlers;

import sunaba.studio.explorer.FileHandler;
import sunaba.studio.CodeEditor;
import sunaba.studio.EditorArea;
import sunaba.studio.codeEditor.HaxePlugin;


class SumlFileHandler extends FileHandler {
    public override function init() {
        this.extension = "suml";
        this.iconPath = "studio://icons/16/document-attribute-s.png";
    }

    public override function openFile(path: String) {
        //var codeEditor = new CodeEditor(editor, EditorArea.workspace);
        //editor.setWorkspaceTabIcon(codeEditor, explorer.loadIcon(iconPath));
        //codeEditor.openFile(path, HaxePlugin);
    }

    public override function getThunbnail(path:String):Texture2D {
        return editor.loadIcon("studio://icons/16_2x/document-attribute-s.png");
    }
}