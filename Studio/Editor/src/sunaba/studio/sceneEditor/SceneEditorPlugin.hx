package sunaba.studio.sceneEditor;

class SceneEditorPlugin extends Node {
    private var _sceneEditor: SceneEditor;
    public var sceneEditor(get, default): SceneEditor;
    function get_sceneEditor(): SceneEditor {
        return _sceneEditor;
    }
    public var editor(get, default): Editor;
    function get_editor() {
        return _sceneEditor.getEditor();
    }
    public var sceneInspector(get, default): SceneInspector;
    function get_sceneInspector(): SceneInspector {
        return _sceneEditor.getEditor().sceneInspector;
    }

    public function new(pSceneEditor: SceneEditor) {
        super();
        initializeProxy();
        _sceneEditor = pSceneEditor;
        init();
    }

    public function init(): Void {
    }
}