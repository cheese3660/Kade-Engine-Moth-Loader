package;

import Options.BotPlay;
import flixel.animation.FlxAnimationController;
import haxe.DynamicAccess;
import flixel.graphics.frames.FlxAtlasFrames;

// typedef AnimationData = {
//     var name:String;
//     var mode:String;

// }

// typedef CharacterData = {
//     var animations:Array<AnimationData>;
//     var startingAnimation:String;
//     var flipWhenPlayer:Bool;
//     var dadVarInit:Float;
// }

typedef StateTransition = {
    from:String,
    to:String
}

typedef DanceTransition = {
    when:String,
    action:String
}

class CharacterJSON {
    public var jsonData:DynamicAccess<Dynamic>;
    var _frames_key:String;
    var _frames_base:String;
    var _frames_library:String;
    public function new(d:DynamicAccess<Dynamic>,key:String,path:String,library:String) {
        jsonData = d;
        _frames_key = key;
        _frames_base = path;
        _frames_library = library;
    }

    public function addAnimations(to:Character, isPlayer: Bool) {
        var ani = to.animation;
        if (jsonData.exists("animations")) {
            var animations:Array<DynamicAccess<Dynamic>> = jsonData.get("animations");
            for (animation in animations) {
                addSingleAnimation(to,animation,ani);
            }
            if (isPlayer && jsonData.exists("animations-player")) {
                animations = jsonData.get("animations-player");
                for (animation in animations) {
                    addSingleAnimation(to,animation,ani);
                }
            } else if (!isPlayer && jsonData.exists("animations-npc")) {
                animations = jsonData.get("animations-npc");
                for (animation in animations) {
                    addSingleAnimation(to,animation,ani);
                }
            }
        } else {
            throw new CharacterJSONException("Expected JSON Description of character to have animations");
        }
    }
    public function getStartAnimation():String {
        return jsonData.get("startingAnimation");
    }

    public function antialiasing():Bool {
        var data:Dynamic = jsonData.get("antialiasing");
        if (data != null) {
            return data;
        } else {
            return true;
        }
    }

    public function pixelCamera():Bool {
        var data:Dynamic = jsonData.get("PixelCamera");
        if (data != null) {
            return data;
        } else {
            return false;
        }
    }

    public function flipX():Bool {
        var data:Dynamic = jsonData.get("flipX");
        if (data != null) {
            return data;
        } else {
            return false;
        }
    }

    public function flipWhenPlayer():Bool {
        var data:Dynamic = jsonData.get("flipWhenPlayer");
        if (data != null) {
            return data;
        } else {
            return false;
        }
    }

    public function isBF():Bool {
        var data:Dynamic = jsonData.get("isBF");
        if (data != null) {
            return data;
        } else {
            return false;
        }
    }

    public function dadVarInit():Float {
        var data:Dynamic = jsonData.get("dadVarInit");
        if (data != null) {
            return data;
        } else {
            return 0.0;
        }
    }

    public function stateTransitions():Array<StateTransition> {
        var data:Dynamic = jsonData.get("stateTransitions");
        if (data != null) {
            return data;
        } else {
            return [];
        }
    }

    public function hasDance():Bool {
        var data:Dynamic = jsonData.get("hasDance");
        if (data != null) {
            return data;
        } else {
            return false;
        }
    }

    public function blockDanceOnPrefix():Bool {
        var data:Dynamic = jsonData.get("blockDanceOnPrefix");
        if (data != null) {
            return data;
        } else {
            return false;
        }
    }

    public function danceBlockPrefix():String {
        var data:Dynamic = jsonData.get("danceBlockPrefix");
        if (data != null) {
            return data;
        } else {
            return "";
        }
    }

    public function rightDance():String {
        var data:Dynamic = jsonData.get("rightDance");
        if (data != null) {
            return data;
        } else {
            return "";
        }
    }

    public function leftDance():String {
        var data:Dynamic = jsonData.get("leftDance");
        if (data != null) {
            return data;
        } else {
            return "";
        }
    }

    public function setDanceWhen():Array<DanceTransition> {
        var data:Dynamic = jsonData.get("setDancedWhen");
        if (data != null) {
            return data;
        } else {
            return [];
        }
    }

    public function enemyOffset():Array<Int> {
        var data:Dynamic = jsonData.get("enemyOffset");
        if (data != null) {
            return data;
        } else {
            return [];
        }
    }

    public function enemyOffsetCamera():Array<Int> {
        var data:Dynamic = jsonData.get("enemyOffsetCamera");
        if (data != null) {
            return data;
        } else {
            return [];
        }
    }
    
    private function addSingleAnimation(to:Character, animation:DynamicAccess<Dynamic>, ani:FlxAnimationController) {
        var animationName: String = animation.get("name");
        var animationMode: String = animation.get("mode");
        var prefix: String = animation.get("prefix");
        var framerate: Dynamic = animation.get("framerate");
        var loop: Dynamic = animation.get("loop");
        var offset: Dynamic = animation.get("offset");
        var flipX: Dynamic = animation.get("flipX");
        var flipY: Dynamic = animation.get("flipY");
        var offset_value: Array<Int> = [0,0];
        if (offset != null) {
            offset_value = offset;
        }
        var loop_value: Bool = true;
        if (loop != null) {
            loop_value = loop; 
        }
        var framerate_value: Int = 30;
        if (framerate != null) {
            framerate_value = framerate;
        }
        var flipX_value: Bool = false;
        if (flipX != null) {
            flipX_value = flipX;
        }
        var flipY_value: Bool = false;
        if (flipY != null) {
            flipY_value = flipY;
        }
        switch (animationMode) {
            case 'prefix': {
                ani.addByPrefix(animationName,prefix,framerate_value,loop_value,flipX_value,flipY_value);
            }
            case 'indices': {
                var indices: Array<Int> = animation.get("indices");
                var postfix: Dynamic = animation.get("postfix");
                var postfix_value: String = "";
                if (postfix != null) {
                    postfix_value = postfix;
                }
                ani.addByIndices(animationName,prefix,indices,postfix_value,framerate_value,loop_value,flipX_value,flipY_value);
            }
        }
        to.addOffset(animationName, offset_value[0], offset_value[1]);
    }

    public function frames() {
        return Paths.getSparrowAtlas(_frames_key, _frames_base, _frames_library);
    }
}