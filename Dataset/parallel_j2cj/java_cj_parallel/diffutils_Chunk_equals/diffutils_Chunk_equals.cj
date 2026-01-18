    public func equals(obj: Chunk<T>): Bool {
        if (lines.isEmpty()) {
            if (!obj.lines.isEmpty()) {
                return false
            }
        } else if ( obj.lines.size != lines.size) {
            return false
        } else {
            var i = obj.lines.size - 1
            while( i>=0 ) {
                if (!(lines[i] == obj.lines[i])) {
                    return false
                }
                i--
            }
        }
        if (position != obj.position) {
            return false
        }
        return true
    }