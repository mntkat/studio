package sunaba.studio;

import sunaba.ui.CenterContainer;
import sunaba.ui.MenuButton;
import sunaba.ui.TextureRect;
import sunaba.ui.Label;
import sunaba.ui.Tree;
import sunaba.ui.Button;
import sunaba.ui.Control;

class Explorer extends EditorWidget {
    var reloadButton: Button;
    var newButton: MenuButton;
    var hamburgerMenuButton: Button;

    var throbberParent: Control;
    var throbberRect: TextureRect;

    var singleColumnTree: Tree;

    public override function editorInit() {
        trace("Hello, World!");
        getEditor().setLeftSidebarTabTitle(this, "Project Explorer");

        var iconBin = io.loadBytes("studio://icons/16_1-5x/blue-folder-stand.png");
        var iconImage = new Image();
        iconImage.loadPngFromBuffer(iconBin);
        var texture = ImageTexture.createFromImage(iconImage);
        getEditor().setLeftSidebarTabIcon(this, texture);

        load("studio://Explorer.suml");

        reloadButton = getNodeT(Button, "vbox/toolbar1/hbox/reload");
        newButton = getNodeT(MenuButton, "vbox/toolbar1/hbox/new");
        hamburgerMenuButton = getNodeT(MenuButton, "vbox/toolbar1/hbox/hamburgerMenu");

        throbberParent = getNodeT(Control, "vbox/toolbar1/hbox/throbber");
        throbberRect = getNodeT(TextureRect, "vbox/toolbar1/hbox/throbber/textureRect");

        singleColumnTree = getNodeT(Tree, "vbox/view/singleColumn/tree");
    }
}