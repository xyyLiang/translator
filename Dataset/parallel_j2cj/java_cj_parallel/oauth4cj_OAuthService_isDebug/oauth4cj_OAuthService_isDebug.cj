    protected func isDebug(): Bool {
        match (debugStream) {
            case None => return false
            case Some(data) => return true
        }
    }