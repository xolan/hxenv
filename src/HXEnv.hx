import Run;
import IO;

/**
    Simple tool to set haxelib libraries' versions as defined in ./.hxenv
**/
class HXEnv extends mcli.CommandLine {
    /**
        Show this message.
    **/
    public function help()
    {
        Sys.println(this.showUsage());
        Sys.exit(0);
    }

    /**
        Check whether the versions defined in ./.hxenv are set
    **/
    public function check() {
        var exists = Run.step1__definitionExists();
        if (exists) {
            IO.printOk('Found definition file');
        } else {
            IO.printErr('Could not find .hxenv file');
            Sys.exit(1);
        }

        var content = Run.step2__getDefinition();
        if (content != null && content != "") {
            IO.printOk('Read contents');
        } else {
            IO.printErr('Error reading contents');
            Sys.exit(1);
        }

        var defined = Run.step3__parsedFromJson(content);
        var definedLibs:Array<Dynamic> = cast defined.libs;
        if (defined != null) {
            var parsedContent = [];
            for (lib in definedLibs) {
                parsedContent.push('     ${lib.name}: ${lib.version}');
            }
            IO.printOk('Parsed contents - found libs: \n${parsedContent.join('\n')}');
        } else {
            IO.printErr('Error parsing contents');
            Sys.exit(1);
        }

        var list = Run.step4__listInstalled();
        var installed = Run.step5__convertList(list);
        
        function maybeInstallAndSetVersions(definedLibs:Array<Dynamic>, installedLibs:Array<Dynamic>) {
            // Look for defined libaries in the installed ones
            for (il in installedLibs) {
                for (dl in definedLibs) {
                    if (il.name == dl.name) {
                        IO.printOk('Found ' + il);
                        if (il.current == dl.version) {
                            IO.printOk('  Correct version (${il.current})');
                        } else {
                            IO.printWarning('  Wrong version (${il.current} != ${dl.version})');
                        }
                    }
                }
            }
        }
        var installedLibs:Array<Dynamic> = cast installed;
        maybeInstallAndSetVersions(definedLibs, installedLibs);
        Sys.exit(0);
    }

    /**
        Use library versions defined in ./.hxenv
    **/
    public function use() {
        var exists = Run.step1__definitionExists();
        if (exists) {
            IO.printOk('Found definition file');
        } else {
            IO.printErr('Could not find .hxenv file');
            Sys.exit(1);
        }

        var content = Run.step2__getDefinition();
        if (content != null && content != "") {
            IO.printOk('Read contents');
        } else {
            IO.printErr('Error reading contents');
            Sys.exit(1);
        }

        var defined = Run.step3__parsedFromJson(content);
        var definedLibs:Array<Dynamic> = cast defined.libs;
        if (defined != null) {
            var parsedContent = [];
            for (lib in definedLibs) {
                parsedContent.push('     ${lib.name}: ${lib.version}');
            }
            IO.printOk('Parsed contents - found libs: \n${parsedContent.join('\n')}');
        } else {
            IO.printErr('Error parsing contents');
            Sys.exit(1);
        }

        var list = Run.step4__listInstalled();
        var installed = Run.step5__convertList(list);
        
        function maybeInstallAndSetVersions(definedLibs:Array<Dynamic>, installedLibs:Array<Dynamic>) {
            // Look for defined libaries in the installed ones
            for (il in installedLibs) {
                for (dl in definedLibs) {
                    if (il.name == dl.name) {
                        IO.printOk('Found ' + il);
                        if (il.current == dl.version) {
                            IO.printOk('  Correct version (${il.current})');
                        } else {
                            IO.printWarning('  Wrong version (${il.current} != ${dl.version})');
                            var setVersionOk = Run.step6__setVersion(dl.name, dl.version);
                            if (!setVersionOk) {
                                IO.printOk('  Installing version (${dl.version})');
                                var installOk = Run.step6_2_install(dl.name, dl.version);
                                if (installOk) {
                                    IO.printOk('  Installed version (${dl.version})');
                                    var setVersionOk2 = Run.step6__setVersion(dl.name, dl.version);
                                    if (!setVersionOk2) {
                                        IO.printErr('    Error setting $dl');    
                                    } else {
                                        IO.printOk('  Set version (${dl.version})');
                                    }
                                } else {
                                    IO.printErr('    Error installing $dl');
                                }
                            } else {
                                IO.printOk('  Set version (${il.current})');
                            }
                        }
                    }
                }
            }
        }
        var installedLibs:Array<Dynamic> = cast installed;
        maybeInstallAndSetVersions(definedLibs, installedLibs);
        Sys.exit(0);
    }

    public function runDefault() {
        this.help();
    }

    public static function main() {
        var d = new mcli.Dispatch(Sys.args());
        d.dispatch(new HXEnv());
    }

}