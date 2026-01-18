    public static func initUUIDSecondLong(l2: Int64): Int64 {
        var ll2: Int64 = l2
        ll2 = rightShift((ll2 << 2), 2) // remove 2 MSB
        ll2 |= (2 << 62) // set 2 MSB to '10'
        return ll2
    }