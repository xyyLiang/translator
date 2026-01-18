    public static func positive(n: Int64, name: String): Int64 {
        if (n <= 0) {
            throw IllegalArgumentException(name + " may not be negative or zero")
        } else {
            return n
        }
    }