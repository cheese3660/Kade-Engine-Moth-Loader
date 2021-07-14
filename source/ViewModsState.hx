package;

import flixel.input.gamepad.FlxGamepad;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.FlxG;


//Mostly copy the options menu for this one

class ViewModsState extends MusicBeatState {
    var options: Array<String>;
    var selected = 0;

	public var acceptInput:Bool = true;

	private var currentDescription:String = "";
	private var grpControls:FlxTypedGroup<Alphabet>;
    
    override function create() {
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menuDesat"));

		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);
        options = [];
        for (mod in ModLoader.loadedMods) {
            options.push(
                mod.name
            );
        }
        options.push("Exit");
        var i = 0;
        for (option in options) {
            var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, option, true, false, true);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i++;
			grpControls.add(controlLabel);
        }

		super.create();

    }

    override function update(elapsed) {
		super.update(elapsed);
        if (acceptInput) {
            if (controls.BACK)
            {
                FlxG.mouse.visible = false;
                FlxG.sound.play(Paths.sound('cancelMenu'));
                FlxG.switchState(new OptionsMenu());
            }

			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeSelection(-1);
				}
				if (gamepad.justPressed.DPAD_DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeSelection(1);
				}
			}
			
			if (FlxG.keys.justPressed.UP)
				changeSelection(-1);
			if (FlxG.keys.justPressed.DOWN)
				changeSelection(1);

            if (controls.ACCEPT) {
                if (selected == options.length - 1) {
                    FlxG.mouse.visible = false;
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    FlxG.switchState(new OptionsMenu());
                }
                //Do nothing on accepting just yet, later show info on the mod
            }

        }
    }
    function changeSelection(change:Int=0) {
		FlxG.sound.play(Paths.sound("scrollMenu"), 0.4);
		selected += change;
		if (selected < 0)
			selected = grpControls.length - 1;
		if (selected >= grpControls.length)
			selected = 0;
        
		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - selected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}
    }
}