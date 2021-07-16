package;
import flixel.FlxSprite;

class Stage {
    public var actors:Map<String,FlxSprite>; //This is a list of actors in the stage, i.e. almost everything in the stage
    public var jsonInfo:StageJSON; //This is the JSON info for the stage
    public var hasLua:Bool; //If the stage has lua
    public var lua:StageLua;
    public var playstate:PlayState;
}