    public func get(id:Int64):Option<BreakpointInfo>{
        if(let Some(i) <- storedInfos.get(id)){
            return i.getOrThrow()
        }else{
            return Option<BreakpointInfo>.None
        }
    }