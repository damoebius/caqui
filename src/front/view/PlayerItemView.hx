package front.view;

import model.Player;
import org.tamina.html.component.HTMLComponent;

@view("", "tx-playeritem")
class PlayerItemView extends HTMLComponent {

    public var player(get,null):Player;

    private var _player:Player;
    public var selected:Bool;

    @skinpart("") private var _playerLabel:js.html.Element;
    @skinpart("") private var _playerInput:js.html.InputElement;

    public function new(player:Player) {
        super();
        _player = player;
    }

    public function update(selected:Bool):Void{
        _playerInput.removeAttribute("checked");
        if(selected){
            _playerInput.setAttribute("checked","checked");
        }
    }

    private function get_player():Player{
        return _player;
    }

    override private function creationCompleteCallback():Void {
        super.creationCompleteCallback();
        if(selected){
            _playerInput.setAttribute("checked","checked");
        }
        _playerLabel.innerHTML += _player.name;
    }

}
