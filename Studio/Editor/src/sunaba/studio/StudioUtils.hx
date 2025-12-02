package sunaba.studio;

import sunaba.App;
import sunaba.Node;
import sunaba.core.native.NativeObject;
import sunaba.core.ArrayList;

class StudioUtils extends Node {
    public static var singleTonNative: NativeObject;

    public static var singleton(get, default): StudioUtils;
    static function get_singleton():StudioUtils {
        return new StudioUtils(singleTonNative);
    }

    public function getBaseDirectory(): String {
        return native.call("GetBaseDirectory", new ArrayList());
    }

    public function getToolchainDirectory(): String {
        return native.call("GetToolchainDirectory", new ArrayList());
    }
}