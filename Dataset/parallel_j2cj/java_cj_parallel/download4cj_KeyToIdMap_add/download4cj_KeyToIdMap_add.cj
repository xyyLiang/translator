    func add(task:DownloadTask,id:Int64):Unit{
        let key:String = generateKey(task)
        keyToIdMap.put(key,id)
        idToKeyMap.put(id,key)
    }