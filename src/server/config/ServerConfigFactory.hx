package server.config;

import php.Global;
import sys.FileSystem;

class ServerConfigFactory {

    public static function getDatabaseConfig():IServerConfig {
        var result:IServerConfig = new LocalServerConfig();
        var serverConfigPath = Global.getenv('DOCUMENT_ROOT') + '/../CAQUI_ServerConfig.php';
        if (FileSystem.exists(serverConfigPath)) {
            Global.require_once(serverConfigPath);
            result = new RemoteServerConfig();
        }
        return result;
    }

}
