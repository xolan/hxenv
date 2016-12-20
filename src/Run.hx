import IO;
import Proxy;

class Run {
    public static function step1__definitionExists() {
        var exists = IO.definitionExists();
        return exists;
    }

    public static function step2__getDefinition() {
        var content = IO.getDefinition();
        return content;
    }

    public static function step3__parsedFromJson(content:String) {
        return haxe.Json.parse(content);
    }

    public static function step4__listInstalled() {
        return Proxy.list();
    }

    public static function step5__convertList(list:String) : Dynamic {
        function parseEntry(entry:String):Dynamic {
            var r = ~/^([A-Z]+): (.+)?$/i;
            var c = ~/^\[.+\]$/i;
            if (r.match(entry)) {
                var name = r.matched(1);
                var versions = [];
                var current = '';
                for (ver in r.matched(2).split(' ')) {
                    if (c.match(ver)) {
                        ver = ver.substring(1, ver.length - 1);
                        current = ver;
                    }
                    versions.push(ver);
                }
                return {
                    name: name,
                    versions: versions,
                    current: current
                };
            }
            return null;
        }

        var libs = [];
        for (line in list.split('\n')) {
            var parsed = parseEntry(line);
            if (parsed != null) {
                libs.push(parsed);
            }
        }
        return libs;
    }

    public static function step6__setVersion(name:String, version:String):Bool {
        var setVersionOk = Proxy.setVersion(name, version);
        return setVersionOk;
    }

    public static function step6_2_install(name:String, version:String):Bool {
        var installOk = Proxy.install(name, version);
        return installOk;
    }
}