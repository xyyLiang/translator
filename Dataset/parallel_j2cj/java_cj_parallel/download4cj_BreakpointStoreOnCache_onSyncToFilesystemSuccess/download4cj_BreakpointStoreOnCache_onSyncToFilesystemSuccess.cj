    public func onSyncToFilesystemSuccess(info:BreakpointInfo,blockIndex:Int64,increaseLength:Int64):Unit{
        let onCacheOne:Option<BreakpointInfo> = this.storedInfos.get(info.id).getOrThrow()
         if(refEq(info, onCacheOne.getOrThrow())){
            onCacheOne.getOrThrow().getBlock(blockIndex).getOrThrow().increaseCurrentOffset(increaseLength)
         }else{
            throw ReadWriteException("Info not on store!")
         }
    }