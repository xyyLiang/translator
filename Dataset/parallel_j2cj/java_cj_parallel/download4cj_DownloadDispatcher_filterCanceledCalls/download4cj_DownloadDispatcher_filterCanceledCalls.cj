
    private func filterCanceledCalls(task:DownloadTask,needCallbackCalls:ArrayList<DownloadCall>,needCancelCalls:ArrayList<DownloadCall>){
        synchronized(m){
            let TempreadyAsyncCalls:ArrayList<DownloadCall> = ArrayList<DownloadCall>()
            for(call in readyAsyncCalls){
                TempreadyAsyncCalls.append(call)
            }
            for(call in TempreadyAsyncCalls){
                if(refEq(call.task,task) ||  call.task.getId() == task.getId()){
                    if (call.isCanceled() || call.isFinishing()){
                        return
                    }

                    readyAsyncCalls.removeIf({mycall:DownloadCall =>
                        let myTask:DownloadTask = mycall.task
                        let b =  refEq(myTask,task)
                        return b
                    })

                    needCallbackCalls.append(call)
                    return
                }
            }

            for (call in runningAsyncCalls) {
                if (refEq(call.task,task) || call.task.getId() == task.getId()) {
                    needCallbackCalls.append(call)
                    needCancelCalls.append(call)
                    return
                }
            }

            for (call in runningSyncCalls) {
                if (refEq(call.task,task) || call.task.getId() == task.getId()) {
                    needCallbackCalls.append(call)
                    needCancelCalls.append(call)
                    return
                }
            }
        }
    }