package server.routes;

import haxe.http.HttpMethod;
import haxe.http.HttpStatus;
import haxe.Json;
import model.Turn;
import php.Lib;
import php.Web;
import server.bll.TurnBLL;
import server.config.IDatabaseConfig;


class TurnRoute extends BaseRoute{

    private var _turnBLL:TurnBLL;

    public function new(config:IDatabaseConfig) {
        super(config);
        _turnBLL = new TurnBLL(config);
    }

    override public function process():Void {
        try {
            if (Web.getMethod() == HttpMethod.Post) {
                var turn:Turn = Json.parse(Web.getPostData());
                _turnBLL.addTurn(turn);

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
