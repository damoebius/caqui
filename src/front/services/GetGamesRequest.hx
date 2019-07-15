package front.services;

import model.RoutesDefinitions;
import model.Game;
import haxe.Json;
import js.html.ProgressEvent;
import haxe.http.HttpStatus;
import js.html.Console;
import js.lib.Promise;
import haxe.http.HttpMethod;
import js.html.XMLHttpRequest;
import js.lib.Error;

class GetGamesRequest {

    private var _request:XMLHttpRequest;

    public function new() {
        _request = new XMLHttpRequest();
        _request.open(HttpMethod.Get,RoutesDefinitions.ENDPOINT+"/"+RoutesDefinitions.GAME);
    }

    public function run(){

        return new Promise(function(resolve, reject){
            _request.addEventListener(XMLHttpRequestEvent.LOAD, function( result:ProgressEvent ):Void {
                var req:XMLHttpRequest = cast result.target;

                if(req.status == HttpStatus.OK){
                    try {
                        var p:Array<Game> = Json.parse(req.response);
                        resolve(p);
                    } catch ( e:Error ) {
                        Console.error(e.message);
                        reject(new Error("Class Mapping Error : Unexpected response Class " + req.response ));
                    }
                } else {
                    reject(new Error("HTTP Error : Unexpected status code " + req.status ));
                }


            });

            _request.addEventListener(XMLHttpRequestEvent.ERROR, function( event:ProgressEvent ):Void {
                var req:XMLHttpRequest = cast event.target;
                var error = new Error(Type.getClassName( Type.getClass(this)) + " Request Error");
                Console.error(error.message);
                reject(error);
            });
            _request.send();
        });
    }
}
