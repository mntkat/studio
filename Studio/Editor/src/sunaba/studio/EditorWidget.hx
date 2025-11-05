package sunaba.studio;

import sunaba.ui.Widget;
import sunaba.io.IoInterface;

class EditorWidget extends Widget {
    private  var parent: Editor;

    public function new(parent: Editor, area: EditorArea, ?io: IoInterface) {
        this.parent = parent;
        if (area == EditorArea.leftSidebar) {
            parent.addLeftSidebarChild(this);
        }
        else if (area == EditorArea.rightSidebar) {
            parent.addRightSidebarChild(this);
        }
        else if (area == EditorArea.workspace) {
            parent.addWorkspaceChild(this);
        }
        super(io);
    }

    public function getEditor(): Editor {
        return parent;
    }
}