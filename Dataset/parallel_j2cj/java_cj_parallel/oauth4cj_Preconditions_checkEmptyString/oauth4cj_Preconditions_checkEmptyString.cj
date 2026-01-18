    public static func checkEmptyString(str: String, errorMsg: String): Unit {
        check(hasText(str), errorMsg)
    }