package;

import flixel.FlxSprite;
import haxe.DynamicAccess;

//Use characterJSON.hx style stuff but without the offsets to create an animation format
class Animations {
    public var anis:Array<Animation>;
    public function new(data:Array<DynamicAccess<Dynamic>>) {
        for (ani in data) {
            anis.push(new Animation(ani));
        }
    }
    public function addAllTo(to:FlxSprite) {
        for (ani in anis) {
            ani.addTo(to);
        }
    }
}