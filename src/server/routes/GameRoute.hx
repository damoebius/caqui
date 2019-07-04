package server.routes;

import model.Game;
import server.bll.GameBLL;
import server.dao.Jouet;
import haxe.crypto.Sha256;
import haxe.http.HttpMethod;
import haxe.http.HttpStatus;
import haxe.io.Mime;
import haxe.Json;
import model.Auth;
import php.Exception;
import php.Lib;
import php.Web;
import php.Global;
import server.bll.SessionBLL;
import server.bll.UserBLL;
import server.config.IDatabaseConfig;
import server.dao.User;



class GameRoute extends SecuredRoute{

    public static final NAME:String = 'game';

    private var _gameBLL:GameBLL;

    public function new(config:IDatabaseConfig) {
        super(config);
        _gameBLL = new GameBLL(config);
    }

    override public function process():Void {
        super.process();
        try {
            if (Web.getMethod() == HttpMethod.Get) {
                var gameId:Int = Std.parseInt(getId());
                if(gameId != null){
                    var game:Game = _gameBLL.getGame(gameId);
                    if(game != null){
                        Web.setReturnCode(HttpStatus.OK);
                        Web.setHeader('Content-type',Mime.ApplicationJson);
                        Lib.print(Json.stringify(game));
                    } else {
                        Web.setReturnCode(HttpStatus.Unauthorized);
                    }
                } else {
                    Web.setReturnCode(HttpStatus.BadRequest);
                }
            } else if (Web.getMethod() != HttpMethod.Options) {
                Web.setReturnCode(HttpStatus.BadRequest);
            }
        } catch (error:Dynamic) {
            Lib.print(error);
            Web.setReturnCode(HttpStatus.BadRequest);
        }
    }
}
