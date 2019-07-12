package model;
class Game {

    public var id:Int;
    public var currentPlayer:Player;
    public var players:Array<Player>;

    public function new(id:Int) {
        this.id = id;
        players=[];
    }


}
