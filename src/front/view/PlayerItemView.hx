package front.view;

import model.Player;
import org.tamina.html.component.HTMLComponent;

@view("", "tx-playeritem")
class PlayerItemView extends HTMLComponent {

    private var _player:Player;
    public var selected:Bool;

    @skinpart("") private var _playerLabel:js.html.Element;
    @skinpart("") private var _playerInput:js.html.InputElement;

    public function new(player:Player) {
        super();
        _player = player;
    }

    override private function creationCompleteCallback():Void {
        super.creationCompleteCallback();
        if(selected){
            _playerInput.setAttribute("checked","checked");
        }
        _playerLabel.innerHTML += _player.name;
    }

}
