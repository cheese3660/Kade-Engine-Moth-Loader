package;

import CharacterJSON.DanceTransition;
import CharacterJSON.StateTransition;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var jsonChar:CharacterJSON;


	//Cached json character variables
	var isBF:Bool=false;
	var dadVarInit:Float=0.0;
	var stateTransitions:Array<StateTransition> = [];
	var hasDance:Bool=false;
	var blockDanceOnPrefix:Bool=false;
	var danceBlockPrefix:String="";
	var danceTransitions:Array<DanceTransition> = [];
	var rightDance:String="";
	var leftDance:String="";

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		trace("loading character " + character);
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		jsonChar = CharacterList.getCharacter(character);
		frames = jsonChar.frames();
		isBF = jsonChar.isBF();
		dadVarInit = jsonChar.dadVarInit();
		stateTransitions = jsonChar.stateTransitions();
		hasDance = jsonChar.hasDance();
		blockDanceOnPrefix = jsonChar.blockDanceOnPrefix();
		danceBlockPrefix = jsonChar.danceBlockPrefix();
		danceTransitions = jsonChar.setDanceWhen();
		rightDance = jsonChar.rightDance();
		leftDance = jsonChar.leftDance();
		jsonChar.addAnimations(this, isPlayer);
		playAnim(jsonChar.getStartAnimation());
		if (jsonChar.pixelCamera()) {
			setGraphicSize(Std.int(width * PlayState.daPixelZoom));
			updateHitbox();
		}
		antialiasing = jsonChar.antialiasing();
		flipX = jsonChar.flipX();

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (jsonChar.flipWhenPlayer())
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (isBF)
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = dadVarInit;

			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}
		for (transition in stateTransitions) {
			if (animation.curAnim.name == transition.from && animation.curAnim.finished) {
				playAnim(transition.to);
				break;
			}
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			if (jsonChar.hasDance()) {
				if ((blockDanceOnPrefix && !animation.curAnim.name.startsWith(danceBlockPrefix)) || !blockDanceOnPrefix) {
					danced = !danced;
					if (danced)
						playAnim(rightDance);
					else
						playAnim(leftDance);
				}
			} else {
				playAnim('idle');
			}
		}
	}

	public function playAnim(animName:String, force:Bool = false, reversed:Bool = false, frame:Int = 0):Void
	{
		animation.play(animName, force, reversed, frame);

		var daOffset = animOffsets.get(animName);
		if (animOffsets.exists(animName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		for (transition in danceTransitions) {
			if (transition.when == animName) {
				switch (transition.action) {
					case "true":
						danced = true;
					case "false":
						danced = false;
					case "invert":
						danced = !danced;
				}
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
