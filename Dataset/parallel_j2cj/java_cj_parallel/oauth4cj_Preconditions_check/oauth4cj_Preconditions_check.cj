    private static func check(requirements: Bool, error: String): Unit {
        if (!requirements) {
            var err: String = DEFAULT_MESSAGE
            if (hasText(error)) {
                err = error
            }
            throw IllegalArgumentException(err)
        }
    }