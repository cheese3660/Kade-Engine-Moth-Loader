package;

import openfl.utils.Assets;
import haxe.DynamicAccess;
import haxe.Exception;
typedef ModContributionType = Int;

class ModContribution {
    public static inline var TYPE_CHARACTER_LIST:ModContributionType = 0;
    public static inline var TYPE_WEEK:ModContributionType = 1;
    public static inline var TYPE_INTRO_TEXT:ModContributionType = 2;
    public static inline var TYPE_ASSET_SWAPS:ModContributionType = 3;  //Asset swaps are described in a json file in the asset swap location
                                                                        //They can be used to replace any asset in the base game (or other mods), but its kinda a clunky system, and for common enough swaps I might just add a seperate contribution type
                                                                        //They also are not recursive and just work by mapping one location to the mods location
                                                                        //The original asset needs "x:x/.../..." shit
    public static inline var TYPE_NOTE_STYLE:ModContributionType = 4;
    //public static inline var TYPE_STAGE:ModContributionType = 5;
    public var mod_path:String;
    public var contribution_type:ModContributionType;
    public var contribution_location:String; //A relative path within the mod, points to a folder
    // public var contribution:DynamicAccess<Dynamic>;
    public function new(path:String, type:ModContributionType,loc:String) {
        mod_path = path;
        contribution_type = type;
        contribution_location = loc;
        check();
    }
    function checkContributionByPath(contribution_path:String) {
        if (!Assets.exists(contribution_path)) {
            throw new NonExistantContributionException('Cannot find asset "$contribution_path" required by mod: ${mod_path}');
        }
    }
    public function check() {
        switch (contribution_type) {
        case TYPE_CHARACTER_LIST:
            checkContributionByPath(Paths.file('$mod_path/$contribution_location/character_list.json', TEXT, "mods"));
        case TYPE_WEEK:
            checkContributionByPath(Paths.file('$mod_path/$contribution_location/week.json', TEXT, "mods"));
        case TYPE_INTRO_TEXT:
            checkContributionByPath(Paths.file('$mod_path/$contribution_location', TEXT, "mods"));
        case TYPE_ASSET_SWAPS:
            checkContributionByPath(Paths.file('$mod_path/$contribution_location/swapinfo.json', TEXT, "mods"));
        case TYPE_NOTE_STYLE:
            checkContributionByPath(Paths.file('$mod_path/$contribution_location/styleinfo.json', TEXT, "mods"));
        }
    }
}
class NonExistantContributionException extends Exception {}