package server.utils;

@:native('PHPMailer\\PHPMailer\\PHPMailer')
extern class PHPMailer {

    public var SMTPDebug:Int;
    public var Host:String;
    public var SMTPAuth:Bool;
    public var Username:String;
    public var Password:String;
    public var SMTPSecure:String;
    public var Port:Int;
    public var Subject:String;
    public var Body:String;
    public var AltBody:String;

    public function new(exceptions:Bool);

    public function send():Void;
    public function isSMTP():Void;
    public function addAddress(value:String):Void;
    public function addReplyTo(value:String):Void;
    public function addCC(value:String):Void;
    public function addBCC(value:String):Void;
    public function setFrom(value:String):Void;

}


