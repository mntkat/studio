package sunaba.studio;

import sunaba.ui.CodeHighlighter;
import sunaba.ui.Button;
import haxe.Exception;
import sunaba.ui.Widget;
import sunaba.core.Color;
import sunaba.desktop.Window;
import sunaba.ui.Label;
import sunaba.ui.CodeEdit;
import sunaba.ui.AspectRatioContainer;
import sunaba.ui.ColorPickerButton;
import sunaba.ui.ColorRect;
import sunaba.ui.GraphEdit;
import sunaba.ui.GraphElement;
import sunaba.ui.GraphFrame;
import sunaba.ui.GraphNode;
import sunaba.ui.HFlowContainer;
import sunaba.ui.HSeparator;
import sunaba.ui.HScrollBar;
import sunaba.ui.HSlider;
import sunaba.ui.VSeparator;
import sunaba.ui.VScrollBar;
import sunaba.ui.VSlider;
import sunaba.ui.LinkButton;
import sunaba.ui.MarginContainer;
import sunaba.ui.MenuButton;
import sunaba.ui.NinePatchRect;
import sunaba.ui.OptionButton;
import sunaba.ui.PanelContainer;
import sunaba.ui.Range;
import sunaba.ui.ReferenceRect;
import sunaba.ui.RichTextEffect;
import sunaba.ui.RichTextLabel;
import sunaba.ui.SpinBox;
import sunaba.ui.TabBar;
import sunaba.ui.TextureButton;
import sunaba.ui.TextureRect;

class SumlEditor extends EditorWidget {
    public var codeEdit: CodeEdit;

    public var lineAndColumnLabel: Label;
    public var languageLabel: Label;
    public var refreshButton: Button;

    public var languageName(get, set): String;
    function get_languageName():String {
        return languageLabel.text;
    }
    function set_languageName(value:String):String {
        return this.languageLabel.text = value;
    }
    public var code(get, set): String;
    function get_code():String {
        return codeEdit.text;
    }
    function set_code(value:String):String {
        return this.codeEdit.text = value;
    }
    public var path: String;
    public var savedCode: String = "";

    public var outputWindow: Window;

    public var previewWidget: Widget = null;

    public override function init() {
        load("studio://SumlEditor.suml");

        codeEdit = getNodeT(CodeEdit, "vbox/hsplit/codeEdit");
        lineAndColumnLabel = getNodeT(Label, "vbox/statusbar/hbox/lineAndColumnLabel");
        languageLabel = getNodeT(Label, "vbox/statusbar/hbox/languageLabel");
        refreshButton = getNodeT(Button, "vbox/statusbar/hbox/refresh");
        refreshButton.pressed.add(() -> {
            refresh();
        });

        outputWindow = getNodeT(Window, "vbox/hsplit/container/subViewport/window");

        var subViewport = getNodeT(SubViewport, "vbox/hsplit/container/subViewport");
        subViewport.transparentBg = true;

        codeEdit.drawControlChars = true;
        codeEdit.lineFolding = true;

        var codeHighlighter = new CodeHighlighter();
        codeHighlighter.numberColor = Color.html("#df7aff");
        codeHighlighter.symbolColor = Color.html("9a9a9a");//"#1dff60");
        codeHighlighter.functionColor = Color.html("#83cdff");
        codeHighlighter.memberVariableColor = Color.html("#00cebe");
        codeHighlighter.addColorRegion("'", "'", Color.html("#9bda7b"));
        codeHighlighter.addColorRegion('"', '"', Color.html("#9bda7b"));
        codeHighlighter.addColorRegion('<!--', '-->', Color.html("#9bda7b"), true);

        codeEdit.syntaxHighlighter = codeHighlighter;
    }

    public override function editorInit() {
        codeEdit.textChanged.add(function() {
            var index = getIndex() - 1;
            var tabTitle = getEditor().getWorkspaceTabTitle(this);
            if (!StringTools.endsWith(tabTitle, "*")) {
                getEditor().setWorkspaceTabTitle(this, tabTitle + "*");
            } else if (code == savedCode) {
                getEditor().setWorkspaceTabTitle(this, StringTools.replace(tabTitle, "*", ""));
            }
        });
    }

    public function openFile(path: String) {
        path = path.split("\\").join("/");
        this.path = path;
        var fileName = path.split("/").pop();
        getEditor().setWorkspaceTabTitle(this, fileName);

        code = io.loadText(path);
        savedCode = code;
        codeEdit.clearUndoHistory();

        refresh();
    }

    public override function onSave() {
        if (code == savedCode)
            return;
        codeEdit.editable = false;
        io.saveText(path, code);
        savedCode = code;
        var tabTitle = getEditor().getWorkspaceTabTitle(this);
        getEditor().setWorkspaceTabTitle(this, StringTools.replace(tabTitle, "*", ""));
    }

    public function refresh() {
        try {
            if (previewWidget == null) {
                previewWidget = new Widget();
                outputWindow.addChild(previewWidget);
                previewWidget.load(path);
            }
            else {
                previewWidget.parseMarkup(code);
            }
        }
        catch(e: Exception) {
            Debug.error(e.message + "\n\n" + e.stack, "Error parsing SUML");
        }
    }

    public override function onProcess(deltaTime: Float) {
        if (codeEdit == null)
            return;
        if (!getEditor().isControlKeyPressed()) {
            codeEdit.editable = true;
        }

        var caretLine = codeEdit.getCaretLine(0);
        var caretColumn = codeEdit.getCaretColumn(0);
        var labelText = "Ln " + Std.string(caretLine) +", Col " + Std.string(caretColumn);
        if (lineAndColumnLabel.text != labelText) {
            lineAndColumnLabel.text = labelText;
        }

        outputWindow.theme = theme;
    }

    public override function onUndo() {
        codeEdit.undo();
    }

    public override function onRedo() {
        codeEdit.redo();
    }
}