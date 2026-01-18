    public func markFileClear(id:Int64):Bool{
         synchronized (m2) {
            try{
                fileDirtyList.remove(id)
            }catch(e:Exception){
                return false
            }
            return true
        }
    }