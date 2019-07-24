package server.bll;

import server.config.IServerConfig;
import server.utils.PHPMailer;
import sys.db.Mysql;

class TurnBLL extends DatabaseBLL {

    private var _gameBLL:GameBLL;

    public function new(config:IServerConfig) {
        super(config);
        _gameBLL = new GameBLL(config);
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
            var mail = new PHPMailer(true);
            mail.SMTPDebug = 2;
            mail.isSMTP();
            mail.Host = _config.mail.host;
            mail.Port = _config.mail.port;
            mail.SMTPAuth = true;
            mail.Username = _config.mail.user;
            mail.Password = _config.mail.pass;
            mail.SMTPSecure = _config.mail.security;
            mail.setFrom('nospam@tamina.io');
            for(adresse in mails){
                mail.addAddress(adresse);
            }
            mail.Subject = "[" + game.name + "] C'est à " + nextPlayer.name + " de jouer";
            mail.Body = "https://caqui.tamina.io";
            mail.send();
        }

    }
}
