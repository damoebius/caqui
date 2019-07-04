package server.bll;

import sys.db.Mysql;
import model.Game;
import server.dao.Jouet;

class GameBLL extends DatabaseBLL{

    public function getGame(gameId:Int):Null<Game>{
        var result:Game = null;
        var connection = Mysql.connect(_config);
        var sqlResult = connection.request("select * from jouet where CODE_J = "+gameId);
        if(sqlResult.length == 1){
            var jouet:Jouet = sqlResult.results().first();
            result = Jouet.toGame(jouet);

        }
        connection.close();
        return result;
    }
}
