package server.bll;

import server.dao.GameDAO;
import sys.db.Mysql;
import model.Game;

class GameBLL extends DatabaseBLL{

    public function getGame(gameId:Int):Null<Game>{
        var result:Game = null;
        var connection = Mysql.connect(_config);
        var sqlResult = connection.request("select * from game where id = "+gameId);
        if(sqlResult.length == 1){
            var game:GameDAO = sqlResult.results().first();
            result = GameDAO.toGame(game);
        }
        connection.close();
        return result;
    }
}
