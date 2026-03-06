package sunaba.studio;

import sunaba.core.Vector2;
import sunaba.ui.ItemList;
import sunaba.ui.OptionButton;
import sunaba.ui.HSlider;
import sunaba.ui.HBoxContainer;
import sunaba.ui.Control;

class CharacterEditor extends EditorWidget {
    public override function editorInit() {
        load("studio://CharacterEditor.suml");

        var minimumSize = customMinimumSize;
        minimumSize.y = 315;
        customMinimumSize = minimumSize;

        getEditor().setDockTabTitle(this, "Character Editor");
        getEditor().setDockTabIcon(this, getEditor().loadIcon("studio://icons/16/toilet-male-edit.png"));
    }
}