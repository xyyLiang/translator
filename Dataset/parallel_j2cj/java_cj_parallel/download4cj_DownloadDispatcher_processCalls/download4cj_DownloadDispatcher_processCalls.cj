    private func processCalls():Unit{
        synchronized(m){
            if (skipProceedCallCount.load() > 0){
                return
            }
            if (runningAsyncSize() >= maxParallelRunningCount){
                return
            }
            if (readyAsyncCalls.isEmpty()){
                return
            }
            let TempreadyAsyncCalls:ArrayList<DownloadCall> = ArrayList<DownloadCall>()
            for(call in readyAsyncCalls){
                TempreadyAsyncCalls.append(call)
            }

            for(call in TempreadyAsyncCalls){
                let task:DownloadTask = call.task

                readyAsyncCalls.removeIf({mycall:DownloadCall =>
                    let myTask:DownloadTask = mycall.task
                    let b = refEq(myTask,task)
                    return b
                })

                runningAsyncCalls.append(call)
                spawn{=>
                    try{
                        call.executeCall()
                    }finally{
                        finish(call)
                    }
                }
                if (runningAsyncSize() >= maxParallelRunningCount){
                    return
                }
            }
        }
    }