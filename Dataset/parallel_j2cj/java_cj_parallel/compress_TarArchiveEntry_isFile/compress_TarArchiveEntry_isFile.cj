    public func isFile(): Bool {
        match(this.file[0]) {
            case Some(v) => return v.isFile()
            case None => 
                if (this.linkFlag == TarConstants.LF_OLDNORM || this.linkFlag == TarConstants.LF_NORMAL) {
                    return true
                }
            return !this.getName().endsWith("/")
        }
    }