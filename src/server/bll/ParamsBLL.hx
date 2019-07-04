package server.bll;

import model.Params;
import server.dao.User;
import sys.db.Mysql;

class ParamsBLL extends DatabaseBLL{


    public function getParams():Params{
        var result:Params = new Params();
        var connection = Mysql.connect(_config);
        var sqlResult = connection.request("SELECT * FROM users where login = '"+username+"' and password = '"+password+"'");
        if(sqlResult.length == 1){
            result = sqlResult.results().first();
        }
        connection.close();
        return result;

    }
}
