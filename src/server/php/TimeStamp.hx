package server.php;

import php.Global;

abstract TimeStamp(String) to String {
    public function new() {
        this = Global.date('Y-m-d H:i:s');
    }
}
