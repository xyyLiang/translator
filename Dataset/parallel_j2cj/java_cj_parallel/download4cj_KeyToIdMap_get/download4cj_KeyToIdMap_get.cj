    func get(task:DownloadTask):Option<Int64>{
        let genKey:String = generateKey(task)
        if(let Some(i) <- keyToIdMap.get(genKey)){
            return i.getOrThrow()
        }else{
            return Option<Int64>.None
        }
    }