package server.config;
interface IDatabaseConfig {
    public var host:String;
    public var user:String;
    public var pass:String;
    public var database:String;
    public var socket:Null<String>;
    public var port:Null<Int>;
}
