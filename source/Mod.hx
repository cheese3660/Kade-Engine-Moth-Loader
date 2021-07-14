package;

import ModContribution.ModContributionType;
import haxe.DynamicAccess;

typedef SimpleContribution = {
    var type: String;
    var location: String;
}

class Mod {
    public var name:String="Unnamed Mod";
    public var path:String;
    public var version:String="No Version Number";
    public var description="No Description";
    public var contributions:Array<ModContribution> = [];
    public function new(path:String, jsonData:DynamicAccess<Dynamic>) {
        this.path = path;
        if (jsonData.exists("name")) {
            name = jsonData.get("name");
        }
        if (jsonData.exists("version")) {
            version = jsonData.get("version");
        }
        if (jsonData.exists("contributes")) {
            var simpleContributions:Array<SimpleContribution> = jsonData.get("contributes");
            for (cont in simpleContributions) {
                switch (cont.type) {
                case 'characters':
                    contributions.push(new ModContribution(path, ModContribution.TYPE_CHARACTER_LIST, cont.location));
                case 'week':
                    contributions.push(new ModContribution(path, ModContribution.TYPE_WEEK, cont.location));
                case 'intro-text':
                    contributions.push(new ModContribution(path, ModContribution.TYPE_INTRO_TEXT, cont.location));
                }
            }
        }
    }

    public function getContributionsOfType(type:ModContributionType) {
        var sortedContributions:Array<ModContribution> = [];
        for (contribution in contributions) {
            if (contribution.contribution_type == type) {
                sortedContributions.push(contribution);
            }
        }
        trace(sortedContributions);
        return sortedContributions;
    }
}