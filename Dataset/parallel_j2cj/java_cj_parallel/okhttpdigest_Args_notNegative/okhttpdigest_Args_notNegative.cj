    public static func notNegative(n: Int32, name: String): Int32 {
        if (n < 0) {
            throw IllegalArgumentException(name + " may not be negative")
        } else {
            return n
        }
    }