    public func applyTo(target: ArrayList<T>): Unit {
        verify(target)
        var position: Int64 = getOriginal().getPosition()
        var size: Int64 = getOriginal().size()
        var i: Int64 = 0
        while (i < size) {
            target.remove(position)
            i++
        }
        i = 0;
        for (line in getRevised().getLines()) {
            target.insert(position + i, line)
            i++
        }
    }