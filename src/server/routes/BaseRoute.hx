package server.routes;
import php.Web;
import php.ErrorException;
import server.config.IDatabaseConfig;

class BaseRoute {

    private var _config:IDatabaseConfig;

    public function new(config:IDatabaseConfig) {
        _config = config;
    }

    public function process():Void {
        throw new ErrorException("not yet implemented");
    }

    public function getId():String{
        return Web.getURI().split('/').pop();
    }
}
