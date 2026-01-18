    public func restore(target: ArrayList<T>): Unit {
        var position: Int64 = getRevised().getPosition()
        var lines: ArrayList<T> = this.getOriginal().getLines()
        var i: Int64 = 0
        try {
            while (i < lines.size) {
                target.insert(position + i, lines.get(i).getOrThrow())
                i++
            }
        } catch(e: IndexOutOfBoundsException) {
            throw DiffException("the position of chunk < 0")
        }
    }