class IO {
    static var _C_RESET = '\033[0m';
    static var _C_RED = '\033[31m';
    static var _C_GREEN = '\033[32m';
    static var _C_YELLOW = '\033[33m';

    static var _I_ERR = '${_C_RED}✗  ${_C_RESET}';
    static var _I_OK = '${_C_GREEN}✓  ${_C_RESET}';
    static var _I_WAR = '${_C_YELLOW}⚠  ${_C_RESET}';

    public static function printOk(str:String) {
        Sys.println('$_I_OK$str');
    }

    public static function printErr(str:String) {
        Sys.println('$_I_ERR$str');
    }

    public static function printWarning(str:String) {
        Sys.println('$_I_WAR$str');
    }

    public static function definitionExists() {
        return sys.FileSystem.exists('./.hxenv');
    }

    public static function getDefinition() {
        return sys.io.File.getContent('./.hxenv');
    }
}