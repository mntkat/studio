import sunaba.OSService;
import sys.FileSystem;
import sunaba.App;

import sunaba.studio.Splashscreen;
import sunaba.studio.StudioUtils;

class Main extends App {
    public static function main() {
        new Main();
    }

	public override function init() {
		var splashscreen = new Splashscreen();
        rootNode.addChild(splashscreen);
	}

    public function onReady() {
        StudioUtils.singleTonNative = rootNode.getNode("/root/StudioUtils").native;

        /*if (!OSService.hasFeature("editor")) {
            var haxelibPath = StudioUtils.singleton.getToolchainDirectory() + "/haxelib";
            if (Sys.systemName() == "Windows") {
                haxelibPath += ".exe";
            }
            if (!FileSystem.exists(Sys.getCwd() + "/.haxelib")) {    
                Sys.command(haxelibPath, ["newrepo"]);
            }
        }*/
    }
}
