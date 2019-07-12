package server.routes;

import haxe.http.HttpMethod;
import haxe.http.HttpStatus;
import haxe.io.Mime;
import haxe.Json;
import model.Game;
import php.Lib;
import php.Web;
import server.bll.GameBLL;
import server.config.IDatabaseConfig;


class GameRoute extends BaseRoute{

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
