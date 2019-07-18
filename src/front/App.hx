package front;

import haxe.Timer;
import js.html.NotificationPermission;
import js.html.Notification;
import front.view.GameView;
import js.Browser;
import js.html.DivElement;
import model.Game;
import org.tamina.html.component.HTMLApplication;
import front.services.GetGamesRequest;

class App extends HTMLApplication{

    private static var _instance:App;

    private var _mainContainer:DivElement;
    private var _views:Array<GameView>;
    private var _timer:Timer;

    private function new() {
        super();
        this.loadComponents();
        if(Notification.permission != NotificationPermission.GRANTED){
            untyped Notification.requestPermission();
        }
        _mainContainer = cast Browser.document.getElementById("mainContainer");
        _views = [];
        var request = new GetGamesRequest();
        request.run().then(games -> showGames(games));
    }

    private function showGames(games:Array<Game>):Void{
        for(game in games){
            var view = new GameView(game);
            _views.push(view);
            _mainContainer.appendChild( view );
        }
        _timer = new Timer(30*1000);
        _timer.run = this.check;
    }

    private function check():Void{
        var request = new GetGamesRequest();
        request.run().then(games -> updateGames(games));
    }

    private function updateGames(games:Array<Game>):Void{
        for(game in games){
            for(view in _views){
                if(game.id == view.game.id && game.currentPlayer.id != view.game.currentPlayer.id){
                    view.game = game;
                    new Notification("C'est à " + game.currentPlayer.name + " de jouer sur " + game.name);
                }
            }
        }
    }

    static public function main() {
        trace("Init!");
        _instance = new App();
    }
}
