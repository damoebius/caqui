package server.bll;

import haxe.crypto.Base64;
import model.Turn;
import sys.io.File;

class TurnBLL extends DatabaseBLL{

    public function addTurn(turn:Turn):Void{
        var file = Base64.decode( turn.file.split(",")[1]);
        File.saveBytes(Sys.getCwd()+"../saves/"+turn.gameId + ".sav",file);
    }
}
