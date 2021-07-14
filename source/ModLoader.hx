package;

import ModContribution.ModContributionType;
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
            throw new NonExistantModException('There is no mod folder named "$mod"');
        }
    }
    
    public static function getContributionsOfType(type:ModContributionType) {
        var sortedContributions:Array<ModContribution> = [];
        for (mod in loadedMods) {
            for (contribution in mod.getContributionsOfType(type)) {
                sortedContributions.push(contribution);
            }
        }
        return sortedContributions;
    }

}

class NonExistantModException extends Exception {}