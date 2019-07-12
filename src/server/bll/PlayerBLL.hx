package server.bll;

import server.dao.PlayerDAO;
import sys.db.Mysql;

class PlayerBLL extends DatabaseBLL{


    public function getUser(username:String,password:String):Null<PlayerDAO>{
        var result:PlayerDAO = null;
        var connection = Mysql.connect(_config);
        var sqlResult = connection.request("SELECT * FROM users where login = '"+username+"' and password = '"+password+"'");
        if(sqlResult.length == 1){
            result = sqlResult.results().first();
        }
        connection.close();
        return result;

    }
}
