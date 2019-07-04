package server.config;

class LocalDatabaseConfig implements IDatabaseConfig {
    public var host:String = "localhost";
    public var user:String= "caquidb";
    public var pass:String= "caquidb";
    public var database:String= "caquidb";
    public var socket:Null<String>;
    public var port:Null<Int>;

    public function new() {}
}

