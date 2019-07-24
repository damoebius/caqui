package server.config;


interface IServerConfig {
    public var db:DatabaseConfig;
    public var mail:Null<SMTPConfig>;
}

typedef DatabaseConfig = {
    public var host:String;
    public var user:String;
    public var pass:String;
    public var database:String;
    public var socket:Null<String>;
    public var port:Null<Int>;
}

typedef SMTPConfig = {
    public var host:String;
    public var user:String;
    public var pass:String;
    public var security:String;
    public var port:Int;
}
