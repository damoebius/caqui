package server.routes;

import server.bll.PlayerBLL;
import haxe.http.HttpMethod;
import haxe.http.HttpStatus;
import haxe.io.Mime;
import haxe.Json;
import php.Lib;
import php.Web;
import server.bll.GameBLL;
import server.config.IDatabaseConfig;


class GameRoute extends BaseRoute{

    private var _gameBLL:GameBLL;

    public function new(config:IDatabaseConfig) {
        super(config);
        _gameBLL = new GameBLL(config);
    }

    override public function process():Void {
        try {
            if (Web.getMethod() == HttpMethod.Get) {

                var games = _gameBLL.getGames();
                Web.setReturnCode(HttpStatus.OK);
                Web.setHeader('Content-type',Mime.ApplicationJson);
                Lib.print(Json.stringify(games));

            } else if (Web.getMethod() != HttpMethod.Options) {
                Web.setReturnCode(HttpStatus.BadRequest);
            }
        } catch (error:Dynamic) {
            Lib.print(error);
            Web.setReturnCode(HttpStatus.BadRequest);
        }
    }
}
