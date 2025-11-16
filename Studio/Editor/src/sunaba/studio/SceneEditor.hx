package sunaba.studio;

import sunaba.ui.SpinBox;
import sunaba.SubViewport;
import sunaba.ui.Button;

class SceneEditor extends EditorWidget {

    public var selectButton: Button;
    public var moveButton: Button;
    public var rotateButton: Button;
    public var scaleButton: Button;

    public var translateSpinBox: SpinBox;
    public var rotateSpinBox: SpinBox;
    public var scaleSpinBox: SpinBox;


    public var viewport: SubViewport;

    public override function init() {
        load("studio://SceneEditor.suml");

        selectButton = getNodeT(Button, "vbox/toolbar/hbox/select");
        moveButton = getNodeT(Button, "vbox/toolbar/hbox/move");
        rotateButton = getNodeT(Button, "vbox/toolbar/hbox/rotate");
        scaleButton = getNodeT(Button, "vbox/toolbar/hbox/scale");

        viewport = getNodeT(SubViewport, "vbox/container/viewport");
    }
}