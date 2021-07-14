package;

import haxe.format.JsonParser;
import openfl.Assets;


typedef AssetSwap = {
    var from: String;
    var to: String;
}

class AssetSwapper {
    static public var initialized = false;
    static public var swaps:Map<String,String> = [];

    static public function initialize() {
        for (contribution in ModLoader.getContributionsOfType(ModContribution.TYPE_ASSET_SWAPS)) {
            var list_path = Paths.file('${contribution.mod_path}/${contribution.contribution_location}/swapinfo.json', TEXT, "mods");
            var text = Assets.getText(list_path);
            var conSwaps:Array<AssetSwap> = JsonParser.parse(text);
            for (swap in conSwaps) {
                swaps[swap.from] = 'mods:mods/${contribution.mod_path}/${contribution.contribution_location}/${swap.to}';
            }
        }

        initialized = true;
    }

    static public function swap(originalPath:String):String {
        if (!initialized || !swaps.exists(originalPath)) return originalPath;
        else return swaps[originalPath];
    }
}