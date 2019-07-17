package server.config;

class LocalDatabaseConfig implements IDatabaseConfig {
    public var host:String = "localhost";
    public var user:String= "root";
    public var pass:String= "root";
    public var database:String= "caquidb";
    public var socket:Null<String>;
    public var port:Null<Int>;

    public function new() {}
}

