     func inspectAnotherSameInfo(task:DownloadTask,info:BreakpointInfo,instanceLength:Int64):Bool{
        if (!task.isFilenameFromResponse()){
            return false
        }

        let store:BreakpointStore = Download4cj.withs().breakpointStore()

        let anotherInfo:Option<BreakpointInfo> = store.findAnotherInfoFromCompare(task, info)

        if(let Some(_) <- anotherInfo){
        }else{
            return false
        }

         if (anotherInfo.getOrThrow().getTotalLength() != instanceLength) {
            return false
        }

        return true
    }