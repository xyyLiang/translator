    public func restore(target: ArrayList<T>): Unit {
        var position: Int64 = getRevised().getPosition()
        var size: Int64 = getRevised().size()
        var i: Int64 = 0
        try {
            while (i < size) {
                if (position < target.size) {
                    target.remove(position)
                } else {
                    break
                }
                i++
            }
            i = 0
            for (line in getOriginal().getLines()) {
                if ((position + i) == target.size) {
                    target.append(line)
                } else {
                    target.insert(position + i, line)
                }
                i++
            }
        } catch(e: IndexOutOfBoundsException) {
            throw DiffException("the position of chunk < 0")
        }
    }