package;

import haxe.macro.Expr.Catch;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxState;

//Put this state before the title state
class ModLoaderState extends MusicBeatState {
    var modsToBeLoaded = 0;
    var modsLoaded = 0;
    var nextModToBeLoaded = "";


    var text:FlxText;
    var mothLogo:FlxSprite;
    var toLoadList:Array<String>;

    var hadException:Bool = false;
    var exception:Dynamic;

    override function create() {
        FlxG.mouse.visible = false;

        FlxG.worldBounds.set(0,0);
        text = new FlxText(FlxG.width / 2, FlxG.height / 2 + 100,0,"Loading mods...");
        text.size = 34;
        text.alignment = FlxTextAlign.CENTER;

        mothLogo = new FlxSprite(FlxG.width / 2, FlxG.height / 2).loadGraphic(Paths.image('MothLogo'));
        mothLogo.x -= mothLogo.width / 2;
        mothLogo.y -= mothLogo.height / 2 + 100;
        // text.y += mothLogo.height / 2 - 125;
        text.x -= 300;
        mothLogo.setGraphicSize(Std.int(mothLogo.width * 0.3));

        add(mothLogo);
        add(text);

        trace("starting moth loader");
        toLoadList = ModLoader.getModsToBeLoaded();
        modsToBeLoaded = toLoadList.length;
        sys.thread.Thread.create(() -> {
            loadMods(); //Don't multithread it for debugging reasons
        });
    }


    override function update(elapsed) {
        if (!hadException) {
            if (modsToBeLoaded != modsLoaded) {
                text.text = 'Loading mods ... $nextModToBeLoaded ($modsLoaded/$modsToBeLoaded)';
            }
        } else {
            throw exception;
        }
        super.update(elapsed);
    }

    function loadMods() {
        trace("loading mods");
        try {
            for (mod in toLoadList) {
                nextModToBeLoaded = mod;
                trace('Loading mod: $mod');
                ModLoader.loadMod(mod);
                modsLoaded++;
            }
            trace("building asset swap map");
            AssetSwapper.initialize();
            trace("caching character data");
            CharacterList.construct();
        } catch (e) {
            hadException = true;
            exception = e;
            while (true) {}
        }
        FlxG.switchState(new TitleState());
    }
}