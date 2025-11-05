package sunaba.studio;

import sunaba.ui.Widget;
import sunaba.ui.Panel;
import sunaba.ui.VBoxContainer;
import sunaba.ui.Label;
import sunaba.ui.MenuBar;
import sunaba.desktop.PopupMenu;
import sunaba.ui.HBoxContainer;
import sunaba.ui.Button;
import sunaba.core.Vector2i;
import sunaba.HorizontalAlignment;
import sunaba.ui.HSplitContainer;
import sunaba.ui.TabContainer;

class Editor extends Widget {
    var sProjPath = "";

    public override function init() {
        load("studio://Editor.suml");
    }

    public override function onReady() {
        var window = getWindow();
        var displayScale = DisplayService.screenGetScale(window.currentScreen);
        if (OSService.getName() == "Windows") {
            var dpi = DisplayService.screenGetDpi(window.currentScreen);
            displayScale = dpi * 0.01;
        }
        window.contentScaleFactor = displayScale;
        var windowSize = new Vector2i(cast 1152 * displayScale, cast 648 * displayScale);
        window.size = windowSize;
        window.minSize = windowSize;
        window.borderless = false;
        window.alwaysOnTop = false;
        window.moveToCenter();
        //window.extendToTitle = true;
        window.mode = WindowMode.maximized;
    }

    // big dumb hack
    private var hasGrabedFocus = false;
    private inline function checkFocus() {
        if (!hasGrabedFocus) {
            getWindow().grabFocus();
            hasGrabedFocus = true;
        }
    }

    public override function onProcess(deltaTime: Float) {
        checkFocus();

    }
}