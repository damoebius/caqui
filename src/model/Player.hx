package model;

class Player {

    public var id:Int;
    public var name:String;
    public var email:String;

    public function new(id:Int, name:String, email:String) {
        this.id = id;
        this.name = name;
        this.email = email;
    }
}
