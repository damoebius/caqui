package front.view;

import model.Game;
import org.tamina.html.component.HTMLComponent;

@view("", "tx-game")
class GameView extends HTMLComponent{

    private var _game:Game;
    @skinpart("") private var _gameTitle:js.html.Element;

    public function new(game:Game) {
        super();
        this.className="col-4";
        _game = game;
    }

    override private function creationCompleteCallback():Void {
        _gameTitle.innerHTML = _game.name;

        super.creationCompleteCallback();
    }

}
