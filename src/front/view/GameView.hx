package front.view;

import js.Browser;
import front.services.PostTurnRequest;
import model.Turn;
import model.Game;
import js.html.*;
import org.tamina.html.component.HTMLComponent;

@view("", "tx-game")
class GameView extends HTMLComponent{

    private var _game:Game;
    private var _reader:FileReader;

    @skinpart("") private var _gameTitle:LinkElement;
    @skinpart("") private var _playersContainer:Element;
    @skinpart("") private var _currentPlayerTitle:Element;
    @skinpart("") private var _fileInput:InputElement;
    @skinpart("") private var _uploadButton:ButtonElement;

    public function new(game:Game) {
        super();
        this.className="col-md-4";
        _game = game;
        _reader = new FileReader();
        _reader.addEventListener('loadend', fileLoadHandler);

    }

    private function upload():Void{
        trace("upload");
        var file:File = _fileInput.files.item(0);
        _reader.readAsDataURL(file);
    }

    private function fileLoadHandler(evt:ProgressEvent):Void {
        var turn = new Turn(_game.id,_game.currentPlayer.id,Date.now(),_reader.result);
        var request = new PostTurnRequest();
        request.run(turn).then(response -> Browser.window.location.reload());
    }


    private function fileChangeHandler(evt:Event):Void {

        var files:FileList = _fileInput.files;
        if (files.length != 0) {
            _uploadButton.removeAttribute("disabled");
        }



    }


    override private function creationCompleteCallback():Void {
        _gameTitle.innerHTML = _game.name;
        _gameTitle.href = "/saves/"+_game.id+".sav";
        _currentPlayerTitle.innerHTML = "C'est à " + _game.currentPlayer.name + " de jouer !";
        for(player in _game.players){
            var item = new PlayerItemView(player);
            item.selected = player.id == _game.currentPlayer.id;
            _playersContainer.appendChild(item);
        }
        _fileInput.addEventListener("change",fileChangeHandler);
        super.creationCompleteCallback();
    }

}
