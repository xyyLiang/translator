    public init(primitive: Int64, size: Int64, b: Int64) {
        this.primitive = primitive
        this.size = size
        this.generatorBase = b
        this.expTable = Array<Int64>(size, item: 0)
        this.logTable = Array<Int64>(size, item: 0)
        var x = 1
        for (i in 0..size) {
            expTable[i] = x
            x *= 2
            if (x >= size) {
                x ^= primitive
                x &= size - 1
            }
        }
        for (i in 0..(size - 1)) {
            logTable[expTable[i]] = i
        }
        this.zero = GenericGFPoly(this, [0])
        this.one = GenericGFPoly(this, [1])
    }