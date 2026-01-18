    public static func notNegative(n: Int64, name: String): Int64 {
        if (n < 0) {
            throw IllegalArgumentException(name + " may not be negative")
        } else {
            return n
        }
    }