package server.bll;

import model.Player;
import server.config.IDatabaseConfig;
import server.dao.TurnDAO;
import haxe.crypto.Base64;
import model.Turn;
import sys.io.File;
import sys.db.Mysql;

class TurnBLL extends DatabaseBLL{

    private var _gameBLL:GameBLL;

    public function new(config:IDatabaseConfig) {
        super(config);
        _gameBLL = new GameBLL(config);
    }

    public function addTurn(turn:Turn):Void{
        var file = Base64.decode( turn.file.split(",")[1]);
        File.saveBytes(Sys.getCwd()+"../saves/"+turn.gameId + ".sav",file);
        var dao = TurnDAO.fromTurn(turn);
        var game = _gameBLL.getGame(turn.gameId);
        var nextPlayerId = game.players[0].id;
        for(i in 0...game.players.length){
            var player = game.players[i];
            if(player.id == game.currentPlayer.id
            && i < game.players.length - 1){
                nextPlayerId = game.players[i+1].id;
            }
        }
        var connection = Mysql.connect(_config);
        //connection.request("INSERT INTO turn () VALUES ()");
        connection.request("UPDATE game SET current_id_player =  " + nextPlayerId);
        connection.close();

    }
}
