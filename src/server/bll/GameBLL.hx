package server.bll;

import server.config.IDatabaseConfig;
import server.dao.GameDAO;
import sys.db.Mysql;
import model.Game;

class GameBLL extends DatabaseBLL{

    private var _playerBLL:PlayerBLL;

    public function new(config:IDatabaseConfig) {
        super(config);
        _playerBLL = new PlayerBLL(config);
    }

    public function getGame(gameId:Int):Null<Game>{
        var result:Game = null;
        var connection = Mysql.connect(_config);
        var sqlResult = connection.request("select * from game where id = "+gameId);
        if(sqlResult.length == 1){
            var game:GameDAO = sqlResult.results().first();
            result = GameDAO.toGame(game);
            result.players = _playerBLL.getGameMembers(game.id);
            result.currentPlayer = _playerBLL.getPlayer(game.current_id_player);
        }
        connection.close();
        return result;
    }

    public function getGames():Array<Game>{
        var result:Array<Game> = [];
        var connection = Mysql.connect(_config);
        var sqlResult = connection.request("select * from game");
        if(sqlResult.length > 0){
            for(res in sqlResult.results() ){
                var dao:GameDAO = res;
                var game = GameDAO.toGame(dao);
                game.players = _playerBLL.getGameMembers(game.id);
                game.currentPlayer = _playerBLL.getPlayer(dao.current_id_player);
                result.push(game);
            }
        }
        connection.close();
        return result;
    }
}
