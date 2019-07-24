package server.config;

import server.config.IServerConfig.SMTPConfig;
import server.config.IServerConfig.DatabaseConfig;

@:native('ServerDatabaseConfig')
extern class RemoteServerConfig implements IServerConfig{

    public var db:DatabaseConfig;
    public var mail:Null<SMTPConfig>;

    public function new();
}
