    public func isDirectory(): Bool {
        match (this.file[0]) {
            case Some(f) => return f.isDirectory()
            case None => 
                if (this.linkFlag == TarConstants.LF_DIR) {
                    return true
                }
                return false
        }
    }