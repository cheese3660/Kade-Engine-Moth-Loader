package;

class SongList {
    public static var songs:Array<SongJSON>;
    public static function initialize() {
        for (week in WeekList.weekOrder) {
            for (song in WeekList.getWeek(week).getAllSongs()) { //Push the songs in order
                songs.push(song);
            }
        }
    }
}