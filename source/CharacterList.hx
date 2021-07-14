package;

import haxe.Json;
import openfl.Assets;
import haxe.DynamicAccess;

class CharacterList {
    public static var cache:Map<String, CharacterJSON> = []; //A character cache
    //public static var builtInData:DynamicAccess<Dynamic>;


    public static function construct() {
        var f = Paths.file("images/characters/character_list.json",TEXT, "shared");
		var jsonText = "";
		if (Assets.exists(f,TEXT)) {
			jsonText = Assets.getText(f);
		}
        //trace(jsonText);
		var jsonDynamic:DynamicAccess<Dynamic> = Json.parse(jsonText);
        for (pair in jsonDynamic.keyValueIterator()) {
            trace(pair);
            cache[pair.key] = Paths.getCharacterJSON(pair.value,"images/characters","shared");
        }
        for (contribution in ModLoader.getContributionsOfType(ModContribution.TYPE_CHARACTER_LIST)) {
            var p = contribution.mod_path;
            var p2 = contribution.contribution_location;
            var f2 = Paths.file('$p/$p2/character_list.json',TEXT,"mods");
            var jtxt2 = "";
            if (Assets.exists(f2, TEXT)) {
                jtxt2 = Assets.getText(f2);
            }
            var modDynamic:DynamicAccess<Dynamic> = Json.parse(jtxt2);
            for (pair in modDynamic.keyValueIterator()) {
                cache[pair.key] = Paths.getCharacterJSON(pair.value,'$p/$p2',"mods");
            }
        }
    }

    // private static function doCache(name: String, data: CharacterJSON) {
    //     cache[name] = data;
    //     return data
    // }

    public static function getCharacter(name: String):CharacterJSON {
        return cache[name];
    }
}