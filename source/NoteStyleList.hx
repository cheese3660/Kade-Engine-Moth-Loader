package;
class NoteStyleList {
    public static var styles:Map<String, NoteStyleJSON>;

    public static function initialize() {
        
    }
    public static function getNoteStyle(styleName:String) {
        return styles[styleName];
    }
}