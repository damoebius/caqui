package model;
class Game {

    public var id:Int;
    public var currentPlayer:Player;
    public var players:Array<Player>;
    public var name:String;

    public function new(id:Int,name:String) {
        this.id = id;
        this.name = name;
        players=[];
    }


}
