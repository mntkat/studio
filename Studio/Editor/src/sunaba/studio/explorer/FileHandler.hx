package sunaba.studio.explorer;

import sunaba.studio.Explorer;
import sunaba.studio.Editor;

class FileHandler {
    public var extension : String = "";
    public var iconPath: String = "";
    public var editor(get, default): Editor;
    function get_editor():Editor {
        return _explorer.getEditor();
    }

    private var _explorer: Explorer;
    public var explorer(get, default): Explorer;
    function get_explorer():Explorer {
        return _explorer;
    }

    public function new(explorer: Explorer) {
        _explorer = explorer;
        init();
    }

    public function init() {}
    public function openFile(path : String) {}
}