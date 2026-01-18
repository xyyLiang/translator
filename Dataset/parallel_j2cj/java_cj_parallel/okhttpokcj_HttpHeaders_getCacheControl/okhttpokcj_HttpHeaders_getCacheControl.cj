    public static func getCacheControl(cacheControl: String, pragma: String): String {
        if (!(cacheControl.isEmpty())) {
            return cacheControl
        } else if (!(pragma.isEmpty())) {
            return pragma
        } else {
            return ""
        }
    }