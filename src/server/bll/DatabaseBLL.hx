package server.bll;

import server.config.IDatabaseConfig;

class DatabaseBLL {

    private var _config:IDatabaseConfig;

    public function new(config:IDatabaseConfig) {
        _config = config;
    }
}
