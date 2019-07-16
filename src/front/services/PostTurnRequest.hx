package front.services;

import haxe.http.HttpMethod;
import haxe.http.HttpStatus;
import haxe.Json;
import js.html.Console;
import js.html.ProgressEvent;
import js.html.XMLHttpRequest;
import js.lib.Error;
import js.lib.Promise;
import model.RoutesDefinitions;
import model.Turn;

class PostTurnRequest {
    private var _request:XMLHttpRequest;

    public function new() {
        _request = new XMLHttpRequest();
        _request.open(HttpMethod.Post, RoutesDefinitions.ENDPOINT + "/" + RoutesDefinitions.TURN);
    }

    public function run(turn:Turn) {

        return new Promise(function(resolve, reject) {
            _request.addEventListener(XMLHttpRequestEvent.LOAD, function(result:ProgressEvent):Void {
                var req:XMLHttpRequest = cast result.target;

                if (req.status == HttpStatus.OK) {
                    resolve(true);
                } else {
                    reject(new Error("HTTP Error : Unexpected status code " + req.status ));
                }

            });

            _request.addEventListener(XMLHttpRequestEvent.ERROR, function(event:ProgressEvent):Void {
                var error = new Error(Type.getClassName(Type.getClass(this)) + " Request Error");
                Console.error(error.message);
                reject(error);
            });

            _request.send(Json.stringify(turn));
        });
    }
}
