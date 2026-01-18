    @OverflowWrapping
    public static func indexOfTerminatorForEncoding(bytes: Array<Int8>, fromIndex: Int32, encoding: Int32): Int32 {
        var terminatorLength: Int32 = 0
        if (encoding == 1 || encoding == 2) {
            terminatorLength = 2
        } else {
            terminatorLength = 1
        }
        return indexOfTerminator(bytes, fromIndex, terminatorLength);
    }