package;

class DifficultyList {
    public static var difficulties:Map<String,Difficulty>;

    public static function initialize() {

    }

    public static function getDifficulty(diffName:String) {
        return difficulties[diffName];
    }
    
    public static function difficultyName(diffName:String) {
        return difficulties[diffName].name;
    }
}