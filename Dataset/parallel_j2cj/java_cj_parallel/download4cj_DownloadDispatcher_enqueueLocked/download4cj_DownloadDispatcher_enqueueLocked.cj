    private func enqueueLocked(tasks:Array<DownloadTask>):Unit{
        synchronized(m){
            let taskList:ArrayList<DownloadTask>  = ArrayList<DownloadTask>()
            taskList.appendAll(tasks)
            if(taskList.size > 1){
                taskList.sortBy({rht:DownloadTask,lht:DownloadTask =>
                    if(rht.getPriority() < lht.getPriority()){
                        return Ordering.GT
                    }
                    if(rht.getPriority() > lht.getPriority()){
                        return Ordering.LT
                    }
                    return Ordering.EQ
                },stable:true)
            }

            let originReadyAsyncCallSize:Int64 = readyAsyncCalls.size
            try{
                let completedTaskList:ArrayList<DownloadTask> = ArrayList<DownloadTask>()
                let sameTaskConflictList:ArrayList<DownloadTask> = ArrayList<DownloadTask>()
                let fileBusyList:ArrayList<DownloadTask> = ArrayList<DownloadTask>()
                for(task in taskList){
                    if (inspectCompleted()){
                        continue
                    }

                    if(inspectForConflict(task, sameTaskConflictList, fileBusyList)){
                        continue
                    }
                    enqueueIgnorePriority(task)
                }
                Download4cj.withs().callbackDispatcher().endTasks(completedTaskList, sameTaskConflictList, fileBusyList)
            }catch(e:Exception){
            }
            if(originReadyAsyncCallSize != readyAsyncCalls.size){
                readyAsyncCalls.sortBy({rht:DownloadCall,lht:DownloadCall =>
                    if(rht.getPriority() < lht.getPriority()){
                        return Ordering.GT
                    }
                    if(rht.getPriority() > lht.getPriority()){
                        return Ordering.LT
                    }
                    return Ordering.EQ
                },stable:true)
            }

        }
    }