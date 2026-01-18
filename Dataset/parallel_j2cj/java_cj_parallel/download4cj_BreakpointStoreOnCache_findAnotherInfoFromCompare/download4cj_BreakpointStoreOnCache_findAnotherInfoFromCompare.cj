    public func findAnotherInfoFromCompare(task:DownloadTask,ignored:BreakpointInfo):Option<BreakpointInfo>{
        let clonedMap:HashMap<Int64,Option<BreakpointInfo>>
        synchronized(m){
            clonedMap = storedInfos.clone()
        }
        let itera:Iterator<Int64>  = clonedMap.keys().iterator()
        while(true){
            var optKey:Option<Int64> = itera.next()
            match(optKey){
                case Some(v)=>
                    let info:Option<BreakpointInfo> =  clonedMap.get(v).getOrThrow()
                    if(let Some(j) <- info){
                        if(refEq(j,ignored)){
                            continue
                        }
                        if(j.isSameFrom(task)){
                            return info
                        }
                    }else{
                        continue
                    }
                case None => break
            }
        }
        return  Option<BreakpointInfo>.None
    }