package;

import CharacterJSON.DanceTransition;
import flixel.FlxSprite;
import haxe.DynamicAccess;

class NoteStyleJSON {
    public var data:DynamicAccess<Dynamic>;
    public var base_path:String;
    public var library:String;
    public var static_animations_base:Animations;
    public var static_animations_directional:Array<Animations>;
    public var animations:Animations;
    public var pixelated:Bool;
    public function new(d:DynamicAccess<Dynamic>,bp:String,lb:String) {
        data = d;
        base_path = bp;
        library = lb;
        static_animations_base = new Animations(data.get("static-animations-base"));
        var static_direction_animation_data:DynamicAccess<Dynamic> = data.get("static-directional-animations");
        static_animations_directional = [];
        static_animations_directional.push(new Animations(static_direction_animation_data.get("left")));
        static_animations_directional.push(new Animations(static_direction_animation_data.get("down")));
        static_animations_directional.push(new Animations(static_direction_animation_data.get("up")));
        static_animations_directional.push(new Animations(static_direction_animation_data.get("right")));
        animations = new Animations(data.get("animations"));
        if (data.exists("pixelated")) {
            pixelated = data.get("pixelated");
        } else {
            pixelated = false;
        }
    }

    public function createStatic(sprite:FlxSprite,direction:Int) {
        var frames_loc:String = data.get("location");
        var frames_type:String = data.get("frame-type");
        switch (frames_type) {
            case 'raw': {
                var frameWidth:Int = data.get("frame-width");
                var frameHeight:Int = data.get("frame-height");
                sprite.loadGraphic(Paths.image(frames_loc, base_path, library),true,frameWidth,frameHeight);
            }
            case 'sparrow':
                sprite.frames = Paths.getSparrowAtlas(frames_loc, base_path, library);
        }
        static_animations_base.addAllTo(sprite);
        static_animations_directional[direction].addAllTo(sprite);
    }

    public function create(sprite:FlxSprite) {
        var frames_loc:String = data.get("location");
        var frames_type:String = data.get("frame-type");
        switch (frames_type) {
            case 'raw': {
                var frameWidth:Int = data.get("frame-width");
                var frameHeight:Int = data.get("frame-height");
                sprite.loadGraphic(Paths.image(frames_loc, base_path, library),true,frameWidth,frameHeight);
            }
            case 'sparrow':
                sprite.frames = Paths.getSparrowAtlas(frames_loc, base_path, library);
        }
        animations.addAllTo(sprite);
    }

}