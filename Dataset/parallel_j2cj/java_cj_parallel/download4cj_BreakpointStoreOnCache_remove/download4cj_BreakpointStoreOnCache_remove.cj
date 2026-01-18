    public func remove(id:Int64):Unit{
        synchronized(m){
            storedInfos.remove(id)
        }
    }