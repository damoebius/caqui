package server.config;

import php.Global;
import sys.FileSystem;

class ServerConfigFactory {

    public static function getDatabaseConfig():IDatabaseConfig {
        var result:IDatabaseConfig = new LocalDatabaseConfig();
        var serverConfigPath = Global.getenv('DOCUMENT_ROOT') + '/../ServerDatabaseConfig.php';
        if (FileSystem.exists(serverConfigPath)) {
            Global.require_once(serverConfigPath);
            result = new ServerDatabaseConfig();
        }
        return result;
    }

}
