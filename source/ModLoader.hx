package;

import haxe.Json;
import haxe.Exception;
import lime.utils.Assets;

class ModLoader {
    public static var loadedMods: Array<Mod> = [];
    public static function getModsToBeLoaded() {
        var f = Paths.file("modList.txt",TEXT,"mods");
        if (Assets.exists(f, TEXT)) {
            var text = Assets.getText(f);
            var lines = text.split("\n");
            var newLines = [];
            for (line in lines) {
                newLines.push(line.split("\r")[0]);
            }
            return newLines;
        } else {
            return [];
        }
    }
    public static function loadMod(mod:String) {
        var file = Paths.file('$mod/modinfo.json',TEXT,"mods");
        if (Assets.exists(file, TEXT)) {
            var text = Assets.getText(file);
            loadedMods.push(new Mod(mod,Json.parse(text)));
        } else {
            trace('Nonexistant mod "$mod"');
            throw new NonExistentModException('There is no mod folder named "$mod"');
        }
    }
}

class NonExistentModException extends Exception {}