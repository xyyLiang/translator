    public static func positive(n: Int32, name: String): Int32 {
        if (n <= 0) {
            throw IllegalArgumentException(name + " may not be negative or zero")
        } else {
            return n
        }
    }
