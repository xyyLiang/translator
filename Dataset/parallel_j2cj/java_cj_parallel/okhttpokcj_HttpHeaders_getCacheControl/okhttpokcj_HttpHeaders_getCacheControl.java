    public static String getCacheControl(String cacheControl, String pragma) {
        // first http1.1, second http1.0
        if (cacheControl != null) return cacheControl;
        else if (pragma != null) return pragma;
        else return null;
    }