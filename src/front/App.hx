package front;

import front.view.GameView;
import js.Browser;
import js.html.DivElement;
import model.Game;
import org.tamina.html.component.HTMLApplication;
import front.services.GetGamesRequest;

class App extends HTMLApplication{

    private static var _instance:App;

    private var _mainContainer:DivElement;

    private function new() {
        super();
        this.loadComponents();
        _mainContainer = cast Browser.document.getElementById("mainContainer");
        var request = new GetGamesRequest();
        request.run().then(games -> showGames(games));
    }

    private function showGames(games:Array<Game>):Void{
        for(game in games){
            trace(game.name);
            _mainContainer.appendChild( new GameView(game) );
        }
    }

    static public function main() {
        trace("Init!");
        _instance = new App();
    }
}
