package;

import haxe.DynamicAccess;

typedef ModContributionType = Int;

class ModContribution {
    public static inline var TYPE_CHARACTER_LIST:ModContributionType = 0;
    public static inline var TYPE_WEEK:ModContributionType = 1;
    public var contribution_type:ModContributionType;
    public var contribution_location:String; //A relative path within the mod, points to a folder
    // public var contribution:DynamicAccess<Dynamic>;
    public function new(type:ModContributionType,loc:String) {
        contribution_type = type;
        contribution_location = loc;
    }
}