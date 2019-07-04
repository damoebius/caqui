package server.bll;

import server.dao.User;
import sys.db.Mysql;

class UserBLL extends DatabaseBLL{


    public function getUser(username:String,password:String):Null<User>{
        var result:User = null;
        var connection = Mysql.connect(_config);
        var sqlResult = connection.request("SELECT * FROM users where login = '"+username+"' and password = '"+password+"'");
        if(sqlResult.length == 1){
            result = sqlResult.results().first();
        }
        connection.close();
        return result;

    }
}
