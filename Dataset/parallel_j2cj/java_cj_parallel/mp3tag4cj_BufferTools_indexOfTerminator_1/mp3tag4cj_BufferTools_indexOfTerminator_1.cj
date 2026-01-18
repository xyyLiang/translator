    @OverflowWrapping
    public static func indexOfTerminator(bytes: Array<Int8>, fromIndex: Int32): Int32 {
        var fromIndexDef: Int32 = fromIndex
        fromIndexDef = 0
        return indexOfTerminator(bytes, fromIndexDef, 1)
    }