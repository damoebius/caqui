package front;

import model.RoutesDefinitions;
import model.Game;
import front.services.GetGamesRequest;
import js.html.Notification;
import js.html.ClientType;
import js.html.CustomEvent;
import haxe.extern.EitherType;
import js.html.FetchEvent;
import js.html.Response;
import js.html.ServiceWorkerGlobalScope;
import js.Promise;
import haxe.Timer;

class SW {

    private static inline var CACHE_NAME:String = "caqui";

    private static var _instance:SW;

    private var _workerScope:ServiceWorkerGlobalScope;
    private var _timer:Timer;
    private var _games:Array<Game>;

    public function new( ) {
        _games = [];
        _workerScope = untyped __js__("self");
        _workerScope.addEventListener(ServiceWorkerEventType.INSTALL, installHandler);
        _workerScope.addEventListener(ServiceWorkerEventType.ACTIVATE, activateHandler);
        _workerScope.addEventListener(ServiceWorkerEventType.FETCH, fetchHandler);
        trace("Worker version : 1.0.1");
    }

    public static function main( ):Void {
        _instance = new SW();
    }

    private function installHandler( event:FetchEvent ):Void {
        trace('installing');
        _workerScope.skipWaiting();

        var cacheFiles = [];

        event.waitUntil(
            _workerScope.caches.open(CACHE_NAME)
            .then(function( cache:js.html.Cache ) {
                return cache.addAll(cacheFiles);
            })
        );
    }

    private function activateHandler( event:FetchEvent ):Void {
        event.waitUntil(
            Promise.all([
                _workerScope.caches.keys().then(function( cacheNames ) {
                    return Promise.all(cacheNames.map(function( key ) {
                        if ( key != CACHE_NAME ) {
                            return _workerScope.caches.delete(key);
                        }

                        return Promise.resolve();
                    }));
                }),
                _workerScope.clients.claim()
            ])
        );
        _timer = new Timer(30*1000);
        _timer.run = this.check;


    }

    private function check():Void{
        _workerScope.fetch(RoutesDefinitions.ENDPOINT+"/"+RoutesDefinitions.GAME)
        .then(response -> response.json().then( json -> this.updateGames(json) ) );
    }


    private function updateGames(games:Array<Game>):Void{
        var changed = false;
        for(game in games){
            for(savedGame in _games){
                if(game.id == savedGame.id && game.currentPlayer.id != savedGame.currentPlayer.id){
                    changed = true;
                }
            }
        }
        if(changed){
            _games = games;
            _workerScope.clients.matchAll({includeUncontrolled: true, type: ClientType.ALL}).then(clients -> {
                trace(clients.length);
                for(client in clients){
                    client.postMessage(_games);
                }
            });
        }
        _games = games;
    }

    private function fetchHandler( event:FetchEvent ):Void {
        event.respondWith(
            _workerScope.caches.match(event.request).then(function( response:Response ):EitherType<Response, Promise<Response>> {
                if ( response != null ) {
                    return response;
                }
                return _workerScope.fetch(event.request);
            })
        );
    }
}

@:enum abstract ServiceWorkerEventType(String) from String to String {

    var INSTALL = "install";
    var ACTIVATE = "activate";
    var MESSAGE = "message";

    var FETCH = "fetch";
    var SYNC = "sync";
    var PUSH = "push";
}
