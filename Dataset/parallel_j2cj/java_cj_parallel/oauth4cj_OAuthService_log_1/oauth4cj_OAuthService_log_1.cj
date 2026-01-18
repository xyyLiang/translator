    protected func log(messagePattern: String, params: Array<String>): Unit {
        for (para in params) {
            println("${messagePattern}: ${para}")
        }
    }