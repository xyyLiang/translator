    func getInfo():Option<BreakpointInfo>{
        if(let Some(i) <- info){
            return i
        }else{
            info = Download4cj.withs().breakpointStore().get(id)
            return info
        }
    }