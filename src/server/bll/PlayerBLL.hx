package server.bll;

import model.Player;
import server.dao.PlayerDAO;
import sys.db.Mysql;

class PlayerBLL extends DatabaseBLL{


    public function getGameMembers(gameId:Int):Array<Player>{
        var result:Array<Player> = [];
        var connection = Mysql.connect(_config);
        var sqlResult = connection.request(
            "SELECT * FROM player AS p
            INNER JOIN game_member as gm
            ON p.id = gm.id_player
            WHERE gm.id_game = " + gameId);
        if(sqlResult.length > 0){
            for(player in sqlResult.results() ){
                result.push(PlayerDAO.toPlayer(player));
            }
        }
        connection.close();
        return result;

    }

    public function getPlayer(playerId:Int):Null<Player>{
        var result:Null<Player> = null;
        var connection = Mysql.connect(_config);
        var sqlResult = connection.request("select * from player where id = "+playerId);
        if(sqlResult.length == 1){
            var player:PlayerDAO = sqlResult.results().first();
            result = PlayerDAO.toPlayer(player);
        }
        connection.close();
        return result;

    }
}
