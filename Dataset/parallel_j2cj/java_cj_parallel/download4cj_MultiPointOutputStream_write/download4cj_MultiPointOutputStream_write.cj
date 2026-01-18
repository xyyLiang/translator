     func write(blockIndex:Int64,bytes:Array<UInt8>){
        synchronized(m){
            if(canceled){
                return
            }
            outputStream(blockIndex).write(bytes)
            store.onSyncToFilesystemSuccess(info,blockIndex,bytes.size)
            outputStreamMap.get(blockIndex).getOrThrow().flushAndSync()
        }
    }