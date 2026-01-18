    private func isDirectory(): Bool {
        return match(this.currEntry) {
            case Some(v) => v.isDirectory()
            case None => false
        }
    }