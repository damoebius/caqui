package model;
class Turn {
    public var id:Int;
    public var gameId:Int;
    public var playerId:Int;
    public var date:Date;
    public var file:String;

    public function new(gameId:Int, playerId:Int, date:Date, file:String) {
        this.gameId = gameId;
        this.playerId = playerId;
        this.date = date;
        this.file = file;
    }


}
