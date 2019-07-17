package model;
class Turn {
    public var id:Int;
    public var gameId:Int;
    public var playerId:Int;
    public var date:Date;

    public function new(gameId:Int, playerId:Int, date:Date) {
        this.gameId = gameId;
        this.playerId = playerId;
        this.date = date;
    }


}
