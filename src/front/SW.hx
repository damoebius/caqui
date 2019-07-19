package front;

import haxe.extern.EitherType;
import js.html.FetchEvent;
import js.html.Response;
import js.html.ServiceWorkerGlobalScope;
import js.Promise;

class SW {

    private static inline var CACHE_NAME:String = "caqui";

    private static var _instance:SW;

    private var _workerScope:ServiceWorkerGlobalScope;

    public function new( ) {
        _workerScope = untyped __js__("self");
        _workerScope.addEventListener(ServiceWorkerEventType.INSTALL, installHandler);
        _workerScope.addEventListener(ServiceWorkerEventType.ACTIVATE, activateHandler);
        _workerScope.addEventListener(ServiceWorkerEventType.FETCH, fetchHandler);
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
