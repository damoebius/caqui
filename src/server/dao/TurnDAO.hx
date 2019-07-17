package server.dao;
import model.Turn;
class TurnDAO {
    public var id:Int;
    public var id_game:Int;
    public var id_player:Int;
    public var date:Date;

    public function new(id_game:Int, id_player:Int, date:Date) {
        this.id_game = id_game;
        this.id_player = id_player;
        this.date = date;
    }


    public static function fromTurn(value:Turn):TurnDAO {
        return new TurnDAO(value.gameId,value.playerId,value.date);
    }

}
