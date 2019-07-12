package server.dao;
import model.Game;
class GameDAO {
    public var id:Int;
    public var current_id_player:Int;
    public var enabled:Bool;

    public static function toGame(source:GameDAO):Game{
        var result = new Game(source.id);
        return result;
    }

}
