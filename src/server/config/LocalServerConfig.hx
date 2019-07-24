package server.config;

import server.config.IServerConfig.SMTPConfig;
import server.config.IServerConfig.DatabaseConfig;

class LocalServerConfig implements IServerConfig {

    public var db:DatabaseConfig;
    public var mail:Null<SMTPConfig>;

    public function new() {
        this.db = {
            host:"localhost",
            user:"root",
            pass:"root",
            database:"caquidb",
            socket:null,
            port:null
        };
    }
}

