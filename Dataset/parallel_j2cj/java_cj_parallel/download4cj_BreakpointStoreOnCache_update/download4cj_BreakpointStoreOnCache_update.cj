    public func update(breakpointInfo:BreakpointInfo):Bool{
        let filename:Option<String> = breakpointInfo.getFilename()
        if(let Some(i) <- filename){
            if(breakpointInfo.isTaskOnlyProvidedParentPath()){
                this.responseFilenameMap.put(breakpointInfo.getUrl(), i);
            }
        }

        let onCacheOne:Option<BreakpointInfo> = this.storedInfos.get(breakpointInfo.id).getOrThrow()
        if(let Some(i) <- onCacheOne){
            if(refEq(i,breakpointInfo)){
                return true
            }
            synchronized(m){
                this.storedInfos.put(breakpointInfo.id, breakpointInfo)
            }
             return true
        }else{
             return false
        }
    }