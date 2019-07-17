package front.services;

import js.html.Blob;
import haxe.http.HttpMethod;
import haxe.http.HttpStatus;
import haxe.Json;
import js.html.Console;
import js.html.ProgressEvent;
import js.html.XMLHttpRequest;
import js.lib.Error;
import js.lib.Promise;
import model.RoutesDefinitions;

class PostTurnRequest {
    private var _request:XMLHttpRequest;
    private var _gameId:Int;
    private var _playerId:Int;
    private var _file:Blob;

    public function new(gameId:Int,playerId,file:Blob) {
        _gameId = gameId;
        _playerId = playerId;
        _file = file;
        _request = new XMLHttpRequest();
        _request.open(HttpMethod.Post, RoutesDefinitions.ENDPOINT + "/" + RoutesDefinitions.TURN+"?gameId="+_gameId+"&playerId="+_playerId);
    }

    public function run() {

        return new Promise(function(resolve, reject) {
            _request.addEventListener(XMLHttpRequestEvent.LOAD, function(result:ProgressEvent):Void {

                if (_request.status == HttpStatus.OK) {
                    resolve(true);
                } else {
                    reject(new Error("HTTP Error : Unexpected status code " + _request.status ));
                }

            });

            _request.addEventListener(XMLHttpRequestEvent.ERROR, function(event:ProgressEvent):Void {
                var error = new Error(Type.getClassName(Type.getClass(this)) + " Request Error");
                Console.error(error.message);
                reject(error);
            });

            _request.send(_file);
        });
    }
}
