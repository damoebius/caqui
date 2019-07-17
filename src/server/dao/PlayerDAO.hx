package server.dao;

import model.Player;
class PlayerDAO {

    public var id:Int;
    public var name:String;
    public var email:String;

    public function new(id:Int, name:String, email:String) {
        this.id = id;
        this.name = name;
        this.email = email;
    }

    public static function toPlayer(source:PlayerDAO):Player{
        var result = new Player(source.id, haxe.Utf8.encode(source.name), haxe.Utf8.encode(source.email));
        return result;
    }
}
