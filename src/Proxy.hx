import IO;

class Proxy {
    public static function list() {
        var p = new sys.io.Process('haxelib', ['list']);
        var output = p.stdout.readAll().toString();
        p.close();
        return output;
    }

    public static function setVersion(name:String, version:String):Bool {
        var p = new sys.io.Process('haxelib', ['set', name, version]);
        var output = p.stdout.readAll().toString();
        var err = p.stderr.readAll().toString();
        var retVal = false;
        if (p.exitCode() == 0) {
            retVal = true;
        } else {
            if (err != "") {
                IO.printErr(err);
            }
            retVal = false;
        }
        p.close();
        return retVal;
    }

    public static function install(name:String, ?version:String):Bool {
        var p:sys.io.Process;
        if (version != null) {
            p = new sys.io.Process('haxelib', ['install', name, version]);
        } else {
            p = new sys.io.Process('haxelib', ['install', name]);
        }
        var output = p.stdout.readAll().toString();
        var err = p.stderr.readAll().toString();
        var retVal = false;
        if (p.exitCode() == 0) {
            retVal = true;
        } else {
            if (err != "") {
                IO.printErr(err);
            }
            retVal = false;
        }
        p.close();
        return retVal;
    }
}