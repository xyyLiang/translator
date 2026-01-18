    public func applyTo(target: ArrayList<T>): Unit {
        verify(target)
        var position: Int64 = getOriginal().getPosition()
        var lines: ArrayList<T> = this.getRevised().getLines()
        var i: Int64 = 0
        while (i < lines.size) {
            target.insert(position + i, lines.get(i).getOrThrow())
            i++
        }
    }