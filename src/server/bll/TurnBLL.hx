package server.bll;

import haxe.io.Bytes;
import model.Player;
import server.config.IDatabaseConfig;
import server.dao.TurnDAO;
import haxe.crypto.Base64;
import model.Turn;
import sys.io.File;
import sys.db.Mysql;
import php.Lib;

class TurnBLL extends DatabaseBLL{

    private var _gameBLL:GameBLL;

    public function new(config:IDatabaseConfig) {
        super(config);
        _gameBLL = new GameBLL(config);
    }

    public function addTurn(gameId:Int,playerId,file:String):Void{
        var fp = php.Global.fopen(Sys.getCwd()+"../saves/"+gameId + ".sav","wb");
        php.Global.fwrite(fp,file);
        var game = _gameBLL.getGame(gameId);
        var nextPlayer = game.players[0];
        var mails:Array<String> = [];
        for(i in 0...game.players.length){
            var player = game.players[i];
            if(player.id == game.currentPlayer.id
            && i < game.players.length - 1){
                nextPlayer = game.players[i+1];
            }
            mails.push(player.email);
        }
        var connection = Mysql.connect(_config);
        //connection.request("INSERT INTO turn () VALUES ()");
        connection.request("UPDATE game SET current_id_player =  " + nextPlayer.id);
        connection.close();

        var tos = mails.join(",");
        var subject = "["+game.name+"] C'est à " + nextPlayer.name + " de jouer";
        var message = "https://caqui.tamina.io";
        trace(tos);
        trace(subject);
        trace(message);
        Lib.mail(tos,subject,message);

    }
}
