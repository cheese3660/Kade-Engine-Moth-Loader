package;

import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import Song.SwagSong;

/*
    An almost complete rewrite of PlayState.hx to support custom weeks
    Everything else also needs to be rewritten in support of this too...
*/

class PlayState extends MusicBeatState
{
	public static var instance:PlayState = null;
    public static var currentStage:String = "";
    public static var currentSongName = "";
    public static var currentSongDifficulty = 0; //TODO: Maybe change this to an enum?
    public static var currentSong:SwagSong;
    public static var inStoryMode = false;
    public static var currentWeek = "tutorial";

    public static var currentWeekSong = 0;
    public static var currentWeekScore = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;

	var inCutscene:Bool = false;

    public static var enemy:Character;
    public static var backgroundCharacter:Character;
    public static var player:Boyfriend;
    public var notes:FlxTypedGroup<Note>;
    private var unspawnNotes:Array<Note> = [];

	public var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var camFollow:FlxObject;

	private static var prevCamFollow:FlxObject;

	private var executeModchart = false;
	
	public function addObject(object:FlxBasic) { add(object); }
	public function removeObject(object:FlxBasic) { remove(object); }

    override public function create() 
    {
        //todo: rewrite this basically
    }

	#if windows
	public static var luaModchart:ModchartState = null;
	#end

    function startCountdown() {
		inCutscene = false;

		generateStaticArrows(0);
		generateStaticArrows(1);
    }

	function generateStaticArrows(player:Int) {
        var songLowercase = StringTools.replace(PlayState.currentSongName, " ", "-").toLowerCase();
        if (executeModchart)
        {
			luaModchart = ModchartState.createModchartState();
			luaModchart.executeState('start',[songLowercase]);
        }
    }
}