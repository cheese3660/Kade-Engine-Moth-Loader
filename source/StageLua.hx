package;

import haxe.format.JsonParser;
import openfl.utils.Assets;
import flixel.FlxSprite;
import openfl.display3D.textures.VideoTexture;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxEase;
import openfl.filters.ShaderFilter;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import lime.app.Application;
import llua.Convert;
import llua.Lua;
import llua.State;
import llua.LuaL;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;

class StageLua extends LuaBase
{
	public var stage:Stage = null;
	public var actorCache:Map<String, Actor>;

	public function getActorByName(id:String):FlxSprite
	{
		return stage.actors[id];
	}

	public function createActor(name:String, actor_info_path:String)
	{
		var triple = Paths.getKeyPathLibraryTriple('actor_info', '${stage.jsonInfo.path}/$actor_info_path', stage.jsonInfo.library);
		var jsonPath = Paths.json(triple[0], triple[1], triple[2]);
		if (Assets.exists(jsonPath))
		{
			var jsonText = Assets.getText(jsonPath);
			var jsonData = JsonParser.parse(jsonText);

			return false;
		}
		else
		{
			return true; // Return true on error
		}
	}

	public function setActorVisibility(name:String, visbility:Bool)
	{
	}

	public function playActorAnimation(actor_name:String, anim_name:String)
	{
	}

	public function addActorToState(name:String)
	{
	}

	public function killActor(name:String)
	{
	}

	public function new(st:Stage, lp:String)
	{
		stage = st;
		super(lp);
		actorCache = [];
		add_callback("createActor", createActor);
		add_callback("setActorVisibility", setActorVisibility);
	}

	public override function kill()
	{
        callLua("stageKilled", []);
        super.kill();
	}
}