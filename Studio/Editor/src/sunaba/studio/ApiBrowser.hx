package sunaba.studio;
import sunaba.ui.Widget;
import sunaba.ui.Label;
import sunaba.ui.Control;
import sunaba.ui.Button;
import sunaba.desktop.Window;
import sunaba.core.Vector2i;
import sunaba.ui.VBoxContainer;
import sunaba.ui.HBoxContainer;
import sunaba.input.InputService;
import sunaba.core.native.NativeReference;
import sunaba.input.InputEventMouseButton;
import sunaba.core.Reference;
import sunaba.core.StringArray;
import sunaba.ui.StyleBoxEmpty;
import sunaba.input.InputEvent;

class ApiBrowser extends Widget {
    public var editor: Editor;

    var menuBarControl: Control;
    public var window:Window;
    public var windowSize:Vector2i;
    private var ogWindowSize: Vector2i;
    public var titlebarLmbPressed:Bool = false;
    public var clickcount = 0;
    public var timeSinceClick = 0.1;
    public var windowTitle:Label;
    var maximizeButton: Button;
    var windowIsMaximized: Bool = false;

    private var resizePreview: Bool = true;
    private var resizeThreshold: Float = 10.0;
    private var resizeThresholdBottomRight: Float = 0.25;

    public var customTitlebar(get, set): Bool;
    function get_customTitlebar() {
        return window.borderless;
    }
    inline function set_customTitlebar(value: Bool): Bool {
        menuBarControl.visible = value;
        return window.borderless = value;
    }

    var isMaximized: Bool;

    private var vbox: VBoxContainer;
    private var menuBarHbox: HBoxContainer;

    public function new(editor: Editor) {
        this.editor = editor;
        super();
    }

    public override function init() {
        load("studio://ApiBrowser.suml");
    }

    public override function onReady() {
        vbox = getNodeT(VBoxContainer, "vbox");
        menuBarHbox = getNodeT(HBoxContainer, "vbox/menuBarControl/hbox");

        window = getWindow();
        window.title = "Api Reference - Sunaba Studio";
        var displayScale = DisplayService.screenGetScale(window.currentScreen);
        if (OSService.getName() == "Windows") {
            var dpi = DisplayService.screenGetDpi(window.currentScreen);
            displayScale = dpi * 0.01;
        }
        window.contentScaleFactor = displayScale;
        windowSize = new Vector2i(cast 1152 * displayScale, cast 648 * displayScale);
        ogWindowSize = windowSize;
        window.size = windowSize;
        window.minSize = windowSize;
        window.alwaysOnTop = false;
        window.moveToCenter();
        window.extendToTitle = true;
        window.mode = WindowMode.windowed;
        window.unresizable = false;
        if (OSService.getName() == "macOS") {
            DisplayService.windowSetWindowButtonsOffset(new Vector2i(35, 37), window.getWindowId());
        }
        else {
            window.borderless = true;
        }


        menuBarControl = getNodeT(Control, "vbox/menuBarControl");
        var menuBarSpacer = getNodeT(Control, "vbox/menuBarControl/hbox/spacer");
        var eventFunc = function(eventN: NativeReference) {
            if (window == null && customTitlebar == false && OSService.getName() != "macOS")
                return;

            if (InputService.isMouseButtonPressed(MouseButton.left) && !titlebarLmbPressed && window.mode == WindowMode.windowed && clickcount == 0) {
                titlebarLmbPressed = true;
                if (eventN.isClass("InputEventMouseButton")) {
                    var eventMouseButton = new InputEventMouseButton(eventN);
                    clickcount++;
                    window.startDrag();
                }
            }
            else if (InputService.isMouseButtonPressed(MouseButton.left) && !titlebarLmbPressed) {
                titlebarLmbPressed = true;
                clickcount++;
            }
            else if (!InputService.isMouseButtonPressed(MouseButton.left) && titlebarLmbPressed) {
                titlebarLmbPressed = false;
            }

            if (clickcount == 2) {
                trace(clickcount);
                clickcount = 0;
                var maximizeButton = getNodeT(Button, "vbox/menuBarControl/hbox/maximizeButton");
                if (windowIsMaximized == true) {
                    var maximizedSize = window.size;
                    window.mode = WindowMode.windowed;
                    windowIsMaximized = false;
                    if (window.size.x == maximizedSize.x && window.size.y == maximizedSize.y) {
                        window.size = ogWindowSize;
                        window.moveToCenter();
                    }
                    else {
                        window.size = windowSize;
                    }
                    maximizeButton.text = "🗖";
                    if (OSService.getName() == "Windows") {
                        maximizeButton.text = "";
                    }
                }
                else if (windowIsMaximized == false) {
                    windowSize = window.size;
                    window.mode = WindowMode.maximized;
                    windowIsMaximized = true;
                    maximizeButton.text = "🗗";
                    if (OSService.getName() == "Windows") {
                        maximizeButton.text = "";
                    }
                }
            }
        };

        var iconContainer = getNodeT(Control, "vbox/menuBarControl/hbox/iconContainer");
        var iconRect = getNodeT(Control, "vbox/menuBarControl/hbox/iconContainer/icon");
        menuBarSpacer.guiInput.connect(eventFunc);
        iconContainer.guiInput.connect(eventFunc);
        iconRect.guiInput.connect(eventFunc);


        var styleBoxEmpty = new StyleBoxEmpty();

        var buttonFont: Font = new SystemFont();
        var buttonSysFont = new SystemFont();
        if (OSService.getName() == "Windows") {//
            buttonSysFont.fontNames = StringArray.fromArray([
                "Segoe Fluent icons",
                "Segoe MDL2 Assets"
            ]);
            buttonFont = buttonSysFont;
        }
        else if (OSService.getName() == "Linux") {
            var fontRes = ResourceLoaderService.load("res://Engine/Theme/fonts/NotoSansSymbols2-Regular.ttf");
            buttonFont = Reference.castTo(fontRes, Font);
        }

        var minimizeButton = getNodeT(Button, "vbox/menuBarControl/hbox/minimizeButton");
        minimizeButton.addThemeStyleboxOverride("normal", styleBoxEmpty);
        minimizeButton.focusMode = FocusModeEnum.none;
        minimizeButton.addThemeFontOverride("font", buttonFont);
        var newCustomMinimumSize = minimizeButton.customMinimumSize;
        minimizeButton.text = "🗕";
        if (OSService.getName() == "Windows") {
            minimizeButton.text = "";
            newCustomMinimumSize.x = 40;
            minimizeButton.customMinimumSize = newCustomMinimumSize;
        }
        minimizeButton.alignment = HorizontalAlignment.center;
        isMaximized = true;
        minimizeButton.pressed.add(() -> {
            if (window.mode != WindowMode.minimized || windowIsMaximized == false) {
                isMaximized = window.mode == WindowMode.maximized;
                window.mode = WindowMode.minimized;
            }
            else {
                if (isMaximized == true) {
                    window.mode = WindowMode.maximized;
                }
                else {
                    window.mode = WindowMode.windowed;
                }
            }
        });

        maximizeButton = getNodeT(Button, "vbox/menuBarControl/hbox/maximizeButton");
        maximizeButton.addThemeStyleboxOverride("normal", styleBoxEmpty);
        maximizeButton.focusMode = FocusModeEnum.none;
        maximizeButton.addThemeFontOverride("font", buttonFont);
        maximizeButton.text = "🗗";
        maximizeButton.alignment = HorizontalAlignment.center;
        if (OSService.getName() == "Windows") {
            maximizeButton.customMinimumSize = newCustomMinimumSize;
        }
        if (window.mode != WindowMode.windowed) {
            maximizeButton.text = "🗗";
            if (OSService.getName() == "Windows") {
                maximizeButton.text = "";
            }
        }
        else {
            maximizeButton.text = "🗖";
            if (OSService.getName() == "Windows") {
                maximizeButton.text = "";
            }
        }
        maximizeButton.pressed.add(() -> {
            if (windowIsFullscreen == true) {
                toggleFullscreen();
                return;
            }
            if (windowIsMaximized == true) {
                maximizeButton.text = "🗖";
                if (OSService.getName() == "Windows") {
                    maximizeButton.text = "";
                }
                var maximizedSize = window.size;
                window.mode = WindowMode.windowed;
                windowIsMaximized = false;
                if (window.size.x == maximizedSize.x && window.size.y == maximizedSize.y) {
                    window.size = ogWindowSize;
                    window.moveToCenter();
                }
                else {
                    window.size = windowSize;
                }
            }
            else {
                windowIsMaximized = true;
                maximizeButton.text = "🗗";
                if (OSService.getName() == "Windows") {
                    maximizeButton.text = "";
                }
                windowSize = window.size;
                window.mode = WindowMode.maximized;
            }
        });

        var closeButton = getNodeT(Button, "vbox/menuBarControl/hbox/closeButton");
        closeButton.addThemeStyleboxOverride("normal", styleBoxEmpty);
        closeButton.focusMode = FocusModeEnum.none;
        closeButton.addThemeFontOverride("font", buttonFont);
        closeButton.text = "🗙";
        if (OSService.getName() == "Windows") {
            closeButton.text = "";
            closeButton.customMinimumSize = newCustomMinimumSize;
        }
        closeButton.alignment = HorizontalAlignment.center;
        closeButton.pressed.add(() -> {
            window.queueFree();
        });
        window.closeRequested.add(() -> {
            window.queueFree();
        });

        if (OSService.getName() == "macOS") {
            iconContainer.hide();
            minimizeButton.hide();
            maximizeButton.hide();
            closeButton.hide();
        }
        else {
            //customTitlebar = editor.customTitlebar;
            customTitlebar = false;
        }

    }


    public override function onProcess(delta:Float) {
        if (OSService.getName() == "macOS") {
            if (OSService.getName() == "macOS") {
                menuBarControl.visible = window.mode != WindowMode.fullscreen;
            }
        }
        if ((windowIsMaximized == false) && OSService.getName() != "macOS" && customTitlebar == true) {
            vbox.offsetBottom = -5;
            vbox.offsetLeft = 5;
            vbox.offsetRight = -5;
            vbox.offsetTop = 5;
            menuBarHbox.offsetLeft = 0;
            menuBarHbox.offsetRight = 0;
        }
        else {
            vbox.offsetBottom = 0;
            vbox.offsetLeft = 0;
            vbox.offsetRight = 0;
            if (menuBarControl.visible) {
                vbox.offsetTop = 5;
                menuBarHbox.offsetLeft = 5;
                menuBarHbox.offsetRight = -5;
            }
            else {
                vbox.offsetTop = 0;
            }
        }

        timeSinceClick -= delta;
        if (timeSinceClick <= 0.0) {
            timeSinceClick = 1.0;
            if (clickcount != 0) {
                clickcount = 0;
            }
        }

        if (OSService.getName() != "macOS" && customTitlebar == true) {
            window = getWindow();
            if (window != null) {
                if (window.mode != WindowMode.windowed) return;

                var windowsize = window.getVisibleRect().size;

                var mousePosition = window.getMousePosition();
                if (mousePosition.x < resizeThreshold && mousePosition.y < resizeThreshold) { // Top left
                    DisplayService.cursorSetShape(CursorShape.fdiagsize);
                    return;
                }
                if (mousePosition.x > windowsize.x - resizeThreshold && mousePosition.y < resizeThreshold) { // Top Right
                    DisplayService.cursorSetShape(CursorShape.bdiagsize);
                    return;
                }
                if (mousePosition.x < resizeThreshold && mousePosition.y > windowsize.y - resizeThreshold) { // Bottom left
                    DisplayService.cursorSetShape(CursorShape.bdiagsize);
                    return;
                }
                if (mousePosition.x > windowsize.x - resizeThreshold && mousePosition.y > windowsize.y - resizeThreshold) { // Bottom Right
                    DisplayService.cursorSetShape(CursorShape.fdiagsize);
                    return;
                }
                if (mousePosition.x < resizeThreshold) { // left
                    DisplayService.cursorSetShape(CursorShape.hsize);
                    return;
                }
                if (mousePosition.x > windowsize.x - resizeThreshold) { // Right
                    DisplayService.cursorSetShape(CursorShape.hsize);
                    return;
                }
                if (mousePosition.y < resizeThreshold) { // Top
                    DisplayService.cursorSetShape(CursorShape.vsize);
                    return;
                }
                if (mousePosition.y > windowsize.y - resizeThreshold) { // Bottom
                    DisplayService.cursorSetShape(CursorShape.vsize);
                    return;
                }
            }
        }
    }

    public override function onInput(event: InputEvent) {
        if (OSService.getName() != "macOS") {
            if (InputService.isKeyLabelPressed(Key.ctrl) && InputService.isKeyLabelPressed(Key.f1)) {
                App.exit(0);
            }
            if (InputService.isKeyLabelPressed(Key.f2)) {
                toggleMenuBar();
            }
            if (InputService.isKeyLabelPressed(Key.f11)) {
                toggleFullscreen();
            }
        }
        else {
            if (InputService.isKeyLabelPressed(Key.meta) && InputService.isKeyLabelPressed(Key.f)) {
                toggleFullscreen();
            }
            if (InputService.isKeyLabelPressed(Key.meta) && InputService.isKeyLabelPressed(Key.q)) {
                App.exit(0);
            }
        }

        if (OSService.getName() != "macOS" && customTitlebar == true) {
            if (event.native.isClass("InputEventMouseButton")) {
                var eventMouseButton = Reference.castTo(event, InputEventMouseButton);
                window = getWindow();
                if (window.mode != WindowMode.windowed) return;
                if (
                eventMouseButton.buttonIndex == MouseButton.left &&
                eventMouseButton.pressed
                ) {
                    var localX = eventMouseButton.position.x;
                    var localY = eventMouseButton.position.y;

                    // Top left
                    if (localX < resizeThreshold && localY < resizeThreshold) {
                        DisplayService.cursorSetShape(CursorShape.fdiagsize);
                        window.startResize(WindowResizeEdge.topLeft);
                        return;
                    }
                    // Top Right
                    if (
                    localX > window.getVisibleRect().size.x - resizeThreshold &&
                    localY < resizeThreshold
                    ) {
                        DisplayService.cursorSetShape(CursorShape.bdiagsize);
                        window.startResize(WindowResizeEdge.topRight);
                        return;
                    }
                    // Bottom left
                    if (
                    localX < resizeThreshold &&
                    localY > window.getVisibleRect().size.y - resizeThreshold
                    ) {
                        DisplayService.cursorSetShape(CursorShape.bdiagsize);
                        window.startResize(WindowResizeEdge.bottomLeft);
                        return;
                    }
                    // Bottom Right
                    if (
                    localX > window.getVisibleRect().size.x - resizeThreshold &&
                    localY > window.getVisibleRect().size.y - resizeThreshold
                    ) {
                        DisplayService.cursorSetShape(CursorShape.fdiagsize);
                        window.startResize(WindowResizeEdge.bottomRight);
                        return;
                    }
                    // Left
                    if (localX < resizeThreshold) {
                        DisplayService.cursorSetShape(CursorShape.hsize);
                        window.startResize(WindowResizeEdge.left);
                        return;
                    }
                    // Right
                    if (localX > window.getVisibleRect().size.x - resizeThreshold) {
                        DisplayService.cursorSetShape(CursorShape.hsize);
                        window.startResize(WindowResizeEdge.right);
                        return;
                    }
                    // Top
                    if (localY < resizeThreshold) {
                        DisplayService.cursorSetShape(CursorShape.vsize);
                        window.startResize(WindowResizeEdge.top);
                        return;
                    }
                    // Bottom
                    if (localY > window.getVisibleRect().size.y - resizeThreshold) {
                        DisplayService.cursorSetShape(CursorShape.vsize);
                        window.startResize(WindowResizeEdge.bottom);
                        return;
                    }
                }
            }
        }
    }

    inline  function toggleMenuBar() {
        menuBarControl.visible = !menuBarControl.visible;
    }

    public var windowIsFullscreen: Bool = false;

    inline function toggleFullscreen() {
        var window = getWindow();
        if (windowIsMaximized != true) {
            window.mode = WindowMode.fullscreen;
            windowIsFullscreen == true;
            windowIsMaximized = true;
        }
        else {
            if (isMaximized == true) {
                window.mode = WindowMode.maximized;
                windowIsMaximized = true;
            }
            else {
                window.mode = WindowMode.windowed;
                windowIsMaximized = false;
            }
            windowIsFullscreen = false;
        }
        if (window.mode != WindowMode.windowed) {
            maximizeButton.text = "🗗";
            if (OSService.getName() == "Windows") {
                maximizeButton.text = "";
            }
        }
        else {
            maximizeButton.text = "🗖";
            if (OSService.getName() == "Windows") {
                maximizeButton.text = "";
            }
        }
    }


}