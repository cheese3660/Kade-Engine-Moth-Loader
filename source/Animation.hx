package;

import flixel.FlxSprite;
import haxe.DynamicAccess;

class Animation {
    public var animation:DynamicAccess<Dynamic>;
    public function new(d:DynamicAccess<Dynamic>) {
        animation = d;
    }

	public function addTo(to:FlxSprite) {
        var animationName: String = animation.get("name");
        var animationMode: String = animation.get("mode");
        var framerate: Dynamic = animation.get("framerate");
        var loop: Dynamic = animation.get("loop");
        var flipX: Dynamic = animation.get("flipX");
        var flipY: Dynamic = animation.get("flipY");
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
                var prefix: String = animation.get("prefix");
                to.animation.addByPrefix(animationName,prefix,framerate_value,loop_value,flipX_value,flipY_value);
            }
            case 'indices': {
                var prefix: String = animation.get("prefix");
                var indices: Array<Int> = animation.get("indices");
                var postfix: Dynamic = animation.get("postfix");
                var postfix_value: String = "";
                if (postfix != null) {
                    postfix_value = postfix;
                }
                to.animation.addByIndices(animationName,prefix,indices,postfix_value,framerate_value,loop_value,flipX_value,flipY_value);
            }
            case 'default': {
                var frames: Array<Int> = animation.get("frames");
                to.animation.add(animationName,frames,framerate_value,loop_value,flipX_value,flipY_value);
            }
        }
    }
}