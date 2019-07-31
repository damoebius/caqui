package server.routes;

import haxe.http.HttpMethod;
import haxe.http.HttpStatus;
import php.Lib;
import php.Web;
import server.bll.GameBLL;
import server.bll.MailBLL;
import server.config.IServerConfig;


class CheckRoute extends BaseRoute{

    private var _gameBLL:GameBLL;
    private var _mailBLL:MailBLL;

    public function new(config:IServerConfig) {
        super(config);
        _gameBLL = new GameBLL(config);
        _mailBLL = new MailBLL(config);
    }

    override public function process():Void {
        try {
            if (Web.getMethod() == HttpMethod.Get) {

                var games = _gameBLL.getGames();
                for(game in games){
                    var mails:Array<String> = [];
                    for (player in game.players) {
                        mails.push(player.email);
                    }
                    _mailBLL.sendMail("RAPPEL [" + game.name + "] C'est toujours à " + game.currentPlayer.name + " de jouer", "https://caqui.tamina.io", mails );
                }
                Web.setReturnCode(HttpStatus.OK);

            } else if (Web.getMethod() != HttpMethod.Options) {
                Web.setReturnCode(HttpStatus.BadRequest);
            }
        } catch (error:Dynamic) {
            Lib.print(error);
            Web.setReturnCode(HttpStatus.BadRequest);
        }
    }
}
