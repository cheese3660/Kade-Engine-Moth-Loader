package;


/*
    This is a loader for modded weeks and for regular weeks, to keep the data all in one place ffs
*/

typedef SequenceEvent = {
    var type:String;
    var location:String;
}

class WeekJSON {
    //Preload everything needed for the week
    //This is a list of assets the week/songs in the week use to load stuff with, its a map of the asset name in the week, to a relative location in the weeks folder 
    public var weekName:String;
    public var weekPath:String;
    public var weekLibrary:String; //The library the week is in like mods, or data

    public var sequence:Array<SequenceEvent>;

    public var sequenceSongs:Map<Int,SongJSON>;

    public function getAllSongs():Array<SongJSON> {
        return [];
    }
}