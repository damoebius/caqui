package server.bll;

import server.config.IServerConfig;
import sys.db.Mysql;

class TurnBLL extends DatabaseBLL {

    private var _gameBLL:GameBLL;
    private var _mailBLL:MailBLL;

    public function new(config:IServerConfig) {
        super(config);
        _gameBLL = new GameBLL(config);
        _mailBLL = new MailBLL(config);
    }

    public function addTurn(gameId:Int, playerId, file:String):Void {
        var fp = php.Global.fopen(Sys.getCwd() + "../saves/" + gameId + ".sav", "wb");
        php.Global.fwrite(fp, file);
        var game = _gameBLL.getGame(gameId);
        var nextPlayer = game.players[0];
        var mails:Array<String> = [];
        for (i in 0...game.players.length) {
            var player = game.players[i];
            if (player.id == game.currentPlayer.id
            && i < game.players.length - 1) {
                nextPlayer = game.players[i + 1];
            }
            mails.push(player.email);
        }
        var connection = Mysql.connect(_config.db);
        connection.request("UPDATE game SET current_id_player =  " + nextPlayer.id + " WHERE id = " + game.id);
        connection.close();
        if (_config.mail != null) {
            _mailBLL.sendMail("[" + game.name + "] C'est à " + nextPlayer.name + " de jouer", "https://caqui.tamina.io", mails );
        }

    }
}
