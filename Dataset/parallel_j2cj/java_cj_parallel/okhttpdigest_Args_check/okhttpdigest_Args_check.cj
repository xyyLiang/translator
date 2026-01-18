    public static func check(expression: Bool, message: String) {
        if (!expression) {
            throw IllegalArgumentException(message)
        }
    }