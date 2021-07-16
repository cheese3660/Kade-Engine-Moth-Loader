package;

import haxe.DynamicAccess;
import openfl.utils.Assets;
import Song.SwagSong;
import flixel.system.FlxSound;

class SongJSON {
    public var name:String;
    public var path:String;
    public var library:String;
    public var offset:Float;
    public var backgroundCharacter:String;
    public var player:String;
    public var hasEnemy:Bool;
    public var enemy:String;
    public var hasModchart:Bool;
    public var modchart:String;
    public var charts:Map<String,String>;
    public var difficultyOrder:Array<String>; //An array of strings to define the order of difficulties
    public var song:String;
    public var hasVoices:Bool;
    public var voices:String;
    public var hasDialog:Bool;
    public var dialogLocation:String;
    public var useCustomIntro:Bool;
    public var customIntro:Map<String,String>; //Use a map here because some things might not be replaced
                                               //TODO: Allow sharing of intro assets between songs so it doesn't need to be replicated
                                               //How to: allow for absolute paths with a ':' in them to denote a library
    public var useCustomRatings:Bool;
    public var customRatings:Map<String, String>;
    public var pixelated:Bool;
    public var noteStyle:String; //I want to have note styles be another contribution type, so they can be shared, and also overriden by other mods easily
    public var discordIcon:String;
    public var camFollowOffsetEnemy:Array<Int>;
    public var camFollowOffsetPlayer:Array<Int>;
    public var enemyVocalVolume:Float;
    public var headbanging:Bool;
    public var zoomOnGoodHit:Bool;
    public var offsetOnConfirm:Bool;
    public var stage:String;

    public function new(jsonData:DynamicAccess<Dynamic>,p:String,l:String) {
        path = p;
        library = l;
        //TODO: Loading all of the song data from the json data
    }

    // private function getLibraryPathValueTriple(assetName:String):Array<String> {
    //     var idx = 0;
    //     if ((idx = assetName.indexOf(':')) >= 0) {
    //         var absLibrary = assetName.substr(0,idx);
    //         var rest = assetName.substr(idx+1);
    //         var lastSlash = assetName.indexOf('/');
    //         var absPath = rest.substr(0, lastSlash);
    //         var absValue = rest.substr(lastSlash+1);
    //         return [absValue, absPath, absLibrary];
    //     } else {
    //         return [assetName, path, library];
    //     }
    // }

    public function updateIntroData(introData:Map<String,Array<String>>) {
        if (useCustomIntro) {
            for (kv in customIntro.keyValueIterator()) {
                var key = kv.key;
                var value = kv.value;
                introData[key] = Paths.getKeyPathLibraryTriple(value, path, library);
            }
        }
    }

    public function updateRatingData(ratingData:Map<String,Array<String>>) {
        if (useCustomRatings) {
            for (kv in customIntro.keyValueIterator()) {
                var key = kv.key;
                var value = kv.value;
                ratingData[key] = Paths.getKeyPathLibraryTriple(value, path, library);
            }
        }
    }

    public function getDialog():Array<String> {
        if (hasDialog) {
            var locationTriple = Paths.getKeyPathLibraryTriple(dialogLocation, path, library);
            return CoolUtil.coolTextFile(Paths.txt(locationTriple[0],locationTriple[1],locationTriple[2]));
        } else {
            return [];
        }
    }

    public function getSong(difficulty:String):SwagSong {
        var location = charts[difficulty];
        var locationTriple = Paths.getKeyPathLibraryTriple(location, path, library);
        var rawJson = Assets.getText(Paths.txt(locationTriple[0],locationTriple[1],locationTriple[2]));
        return Song.parseJSONshit(rawJson);
    }

    public function getVocals():FlxSound {
        if (hasVoices) {
            var locationTriple = Paths.getKeyPathLibraryTriple(voices, path, library);
            return new FlxSound().loadStream(Paths.sound(locationTriple[0],locationTriple[1],locationTriple[2]),false);
        } else {
            return new FlxSound();
        }
    }
    public function getInstrumental():String {
        var locationTriple = Paths.getKeyPathLibraryTriple(song, path, library);
        return Paths.sound(locationTriple[0],locationTriple[1],locationTriple[2]);
    }
}