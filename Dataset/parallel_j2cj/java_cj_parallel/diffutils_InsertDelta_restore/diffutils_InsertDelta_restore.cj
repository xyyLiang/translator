    public func restore(target: ArrayList<T>): Unit {
        var position: Int64 = getRevised().getPosition()
        var size: Int64 = getRevised().size()
        var i: Int64 = 0
        try {
            while (i < size) {
                target.remove(position)
                i++
            }
        } catch(e: IndexOutOfBoundsException) {
            throw DiffException("the position of chunk < 0")
        }
    }