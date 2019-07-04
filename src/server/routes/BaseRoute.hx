package server.routes;
import server.bll.SessionBLL;
import php.Web;
import php.ErrorException;
import server.config.IDatabaseConfig;

class BaseRoute {

    private var _config:IDatabaseConfig;
    private var _sessionBLL:SessionBLL;

    public function new(config:IDatabaseConfig) {
        _config = config;
        _sessionBLL = new SessionBLL(config);
    }

    public function process():Void {
        throw new ErrorException("not yet implemented");
    }

    public function getId():String{
        return Web.getURI().split('/').pop();
    }
}
