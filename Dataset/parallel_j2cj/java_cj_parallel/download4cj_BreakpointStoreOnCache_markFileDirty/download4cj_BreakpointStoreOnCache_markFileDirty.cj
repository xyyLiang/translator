    public func markFileDirty(id:Int64):Bool{
        if (!fileDirtyList.contains(id)){
            synchronized(m2){
                if (!fileDirtyList.contains(id)) {
                     fileDirtyList.append(id)
                     return true
                }
            }
        }
        return false
    }