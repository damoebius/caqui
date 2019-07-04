package server.bll;

import server.dao.ApiSession;
import sys.db.Mysql;
import server.php.TimeStamp;

class SessionBLL extends DatabaseBLL{

    public function getSession(userId:Int):Null<ApiSession>{
        var result:ApiSession = null;
        var connection = Mysql.connect(_config);
        var sqlResult = connection.request("SELECT * FROM api_session where id_user = '"+userId+"'");
        if(sqlResult.length == 1){
            result = sqlResult.results().first();
        }
        connection.close();
        return result;

    }

    public function isValidToken(token:String):Bool{
        var result = false;
        var connection = Mysql.connect(_config);
        var sqlResult = connection.request("SELECT * FROM api_session where token = '"+token+"'");
        result = sqlResult.length == 1;
        connection.close();
        return result;

    }

    public function createSession(userId:Int,token:String):Void{
        var connection = Mysql.connect(_config);
        connection.request("INSERT INTO api_session SET id_user = '"+userId+"', token = '"+token+"' ON DUPLICATE KEY UPDATE id_user = '"+userId+"', token = '"+token+"', created_at = '"+ new TimeStamp()+"'");
        connection.close();

    }
}
