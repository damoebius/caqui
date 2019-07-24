package server.routes;
import php.Web;
import php.ErrorException;
import server.config.IServerConfig;

class BaseRoute {

    private var _config:IServerConfig;

    public function new(config:IServerConfig) {
        _config = config;
    }

    public function process():Void {
        throw new ErrorException("not yet implemented");
    }

    public function getId():String{
        return Web.getURI().split('/').pop();
    }
}
