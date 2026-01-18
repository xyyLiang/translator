    protected static func checkNumeric(contents: String) {
        if (let None = NUMERIC.matcher(contents).find()) {
            throw IllegalArgumentException("Input should only contain digits 0-9")
        }
    }