    public func available(): Int64 {
        if (this.isDirectory()) {
            return 0
        }

        if (currEntry.getOrThrow().getRealSize() - entryOffset > Int64(Int32.Max)) {
            return Int64(Int32.Max)
        }
        return currEntry.getOrThrow().getRealSize() - entryOffset
    }