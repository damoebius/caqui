package model;
class Mock {

    public static function getGames():Array<Game>{
        var result = new Array<Game>();

        var g = new Game(1,"Paaaaaarttyyyyyyy");
        g.players.push(new Player(1,"titom","titom@tamina-online.com"));
        g.players.push(new Player(2,"damo","damo@tamina.io"));
        g.players.push(new Player(3,"sylco","sylco@tamina-online.com"));
        g.currentPlayer = g.players[1];
        result.push(g);

        var g1 = new Game(37,"gogogo");
        g1.players.push(new Player(1,"titom","titom@tamina-online.com"));
        g1.players.push(new Player(2,"damo","damo@tamina.io"));
        g1.players.push(new Player(3,"sylco","sylco@tamina-online.com"));
        g1.players.push(new Player(4,"Paul","sylco@tamina-online.com"));
        g1.currentPlayer = g1.players[2];
        result.push(g1);

        return result;
    }

}
