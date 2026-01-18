    private static func med3(a: Int64, b: Int64, c: Int64): Int64 {
        return if (a < b) {
            if (b < c) {
                b
            } else if (a < c) {
                c
            } else {
                a
            }
        } else {
            if (b > c) {
                b
            } else if (a > c) {
                c
            } else {
                a
            }
        }
    }