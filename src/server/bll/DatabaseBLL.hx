package server.bll;

import server.config.IServerConfig;

class DatabaseBLL {

    private var _config:IServerConfig;

    public function new(config:IServerConfig) {
        _config = config;
    }
}
