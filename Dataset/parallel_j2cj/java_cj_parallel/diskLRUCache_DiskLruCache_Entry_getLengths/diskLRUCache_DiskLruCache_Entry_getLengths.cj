    public func getLengths(): String {
        var result = StringBuilder()
        for (src in lengths) {
            result.append(' ')
            result.append(src)
        }
        return result.toString()
    }