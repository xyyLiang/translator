    protected func log(message: String): Unit {
        if (isDebug()) {
            log(message, Array<String>())
        }
    }