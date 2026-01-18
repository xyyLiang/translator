    func finish(call:DownloadCall):Unit{
        synchronized(m){
            let asyncExecuted:Bool = call.asyncExecuted
            var callsa:ArrayList<DownloadCall> = ArrayList<DownloadCall>()
            if(finishingCalls.contains(call)){
                callsa = finishingCalls
            }else if(asyncExecuted){
                callsa = runningAsyncCalls
            }else{
                callsa = runningSyncCalls
            }
            try{
                callsa.removeIf({mycall:DownloadCall =>
                    let myTask:DownloadTask = mycall.task
                    let b = refEq(myTask,call.task)
                    return b
                })
            }catch(e:Exception){
                throw IllegalStateException("Call wasn't in-flight!")
            }
            if (asyncExecuted && call.isCanceled()){
                flyingCanceledAsyncCallCount.fetchSub(1)
            }
            if (asyncExecuted){
                 processCalls()
            }
        }
    }