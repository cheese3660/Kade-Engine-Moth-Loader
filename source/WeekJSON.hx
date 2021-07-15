package;


/*
    This is a loader for modded weeks and for regular weeks, to keep the data all in one place ffs
*/

class WeekJSON {
    //Preload everything needed for the week
    //This is a list of assets the week/songs in the week use to load stuff with, its a map of the asset name in the week, to a relative location in the weeks folder 
    public var namedAssets:Map<String,String>;
    public var weekName:String;
    public var weekPath:String;
    public var weekLibrary:String; //The library the week is in like mods
}