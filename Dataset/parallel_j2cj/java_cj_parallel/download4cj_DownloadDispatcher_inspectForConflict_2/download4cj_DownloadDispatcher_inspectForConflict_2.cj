    func inspectForConflict(task:DownloadTask,calls:ArrayList<DownloadCall>,sameTaskList:Option<ArrayList<DownloadTask>>,fileBusyList:Option<ArrayList<DownloadTask>>){
        let callbackDispatcher:CallbackDispatcher = Download4cj.withs().callbackDispatcher()
        let TempCalls:ArrayList<DownloadCall> = ArrayList<DownloadCall>()
        for(call in calls){
            TempCalls.append(call)
        }
        for(call in TempCalls){
            if(call.isCanceled()){
                continue
            }

            if(refEq(call.task,task)||call.task.getId() == task.getId()){
                if(call.isFinishing()){
                    Util.d(TAG, "task: "+task.getId().toString()+" is finishing, move it to finishing list")
                    finishingCalls.append(call)
                    calls.removeIf({mycall:DownloadCall =>
                        let b = refEq(mycall,call)
                        return b
                    })
                    return false
                }

                if(let Some(i) <- sameTaskList){
                    i.append(task)
                }else{
                    callbackDispatcher.dispatch().taskEnd(task,Option<Exception>.None)
                }
                return true
            }

            if(let Some(i) <- fileBusyList){
                if(i.size>0){
                    println("fileBusyListSize="+i.size.toString())
                }
            }
        }
        return false
    }