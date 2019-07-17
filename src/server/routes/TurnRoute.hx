package server.routes;

import haxe.http.HttpMethod;
import haxe.http.HttpStatus;
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
        trace("aaaaa");
        try {
            if (Web.getMethod() == HttpMethod.Post) {
                var params = Web.getParams();
                var file:String = cast php.Global.file_get_contents('php://input');
                trace("sdsss");
                _turnBLL.addTurn(Std.parseInt(params.get("gameId")),Std.parseInt(params.get("playerId")),file);

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
