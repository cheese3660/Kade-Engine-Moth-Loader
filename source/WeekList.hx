package;

class WeekList {
    public static var weeks:Map<String,WeekJSON>;
    public static var weekOrder:Array<String>; //A week order used for denoting weeks within menus

    public static function initialize() {

    }

    public static function getWeek(weekName:String) {
        return weeks[weekName];
    }
}