    static func compareUInts(i1: Int32, i2: Int32):Int32 {
        /* if both have same sign, normal comparison (by subtraction) works fine
         * but if signs don't agree need to resolve diffserently
         */
        if (i1 < 0) {
            if(i2 < 0) {
                return (i1 - i2)
            }
            return 1
        }
        if(i2 < 0) {
            return -1
        } else {
            return (i1 - i2)
        }
        
    }