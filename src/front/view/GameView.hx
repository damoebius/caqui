package front.view;

import front.services.PostTurnRequest;
import js.Browser;
import js.html.*;
import model.Game;
import org.tamina.html.component.HTMLComponent;

@view("", "tx-game")
class GameView extends HTMLComponent{

    public var game(get,set):Game;
    private var _game:Game;

    private var _views:Array<PlayerItemView>;

    @skinpart("") private var _gameTitle:LinkElement;
    @skinpart("") private var _playersContainer:Element;
    @skinpart("") private var _currentPlayerTitle:Element;
    @skinpart("") private var _fileInput:InputElement;
    @skinpart("") private var _uploadButton:ButtonElement;

    public function new(game:Game) {
        super();
        this.className="col-md-4";
        _game = game;
        _views = [];
    }

    private function get_game():Game{
        return _game;
    }

    private function set_game(value:Game):Game{
        _game = value;
        updateView();
        return _game;
    }

    private function upload():Void{
        trace("upload");
        var file:File = _fileInput.files.item(0);
        var request = new PostTurnRequest(_game.id,_game.currentPlayer.id,file);
        request.run().then(response -> Browser.window.location.reload());
    }

    private function fileChangeHandler(evt:Event):Void {
        var files:FileList = _fileInput.files;
        if (files.length != 0) {
            _uploadButton.removeAttribute("disabled");
        }
    }

    private function updateView():Void{
        _currentPlayerTitle.innerHTML = "C'est à " + _game.currentPlayer.name + " de jouer !";
        _playersContainer.innerHTML = "";
        for(player in _game.players){
            var item = new PlayerItemView(player);
            item.selected = player.id == _game.currentPlayer.id;
            _views.push(item);
            _playersContainer.appendChild(item);
        }
    }


    override private function creationCompleteCallback():Void {
        _gameTitle.innerHTML = _game.name;
        _gameTitle.href = "/saves/"+_game.id+".sav";
        _currentPlayerTitle.innerHTML = "C'est à " + _game.currentPlayer.name + " de jouer !";
        for(player in _game.players){
            var item = new PlayerItemView(player);
            item.selected = player.id == _game.currentPlayer.id;
            _views.push(item);
            _playersContainer.appendChild(item);
        }
        _fileInput.addEventListener("change",fileChangeHandler);
        super.creationCompleteCallback();
    }

}
