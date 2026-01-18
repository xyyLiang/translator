    private func handleCanceledCalls(needCallbackCalls:ArrayList<DownloadCall>,needCancelCalls:ArrayList<DownloadCall>){
        synchronized(m){
            Util.d(TAG, "handle cancel calls, cancel calls: " + needCancelCalls.size.toString())

           if (!needCancelCalls.isEmpty()) {
                for(call in needCancelCalls){
                     if (!call.cancel()) {
                        needCallbackCalls.removeIf({mycall:DownloadCall =>
                            let myTask:DownloadTask = mycall.task
                            let b = refEq(myTask,call.task)
                            return b
                        })
                     }
                }
           }

            Util.d(TAG, "handle cancel calls, callback cancel event: " + needCallbackCalls.size.toString())
            if (!needCallbackCalls.isEmpty()) {
                if (needCallbackCalls.size <= 1) {
                    let call:DownloadCall = needCallbackCalls.get(0).getOrThrow()
                    Download4cj.withs().callbackDispatcher().dispatch().taskEnd(call.task,Option<Exception>.None)
                } else {
                    let callbackCanceledTasks:ArrayList<DownloadTask> = ArrayList<DownloadTask>()
                    for (call in needCallbackCalls) {
                        callbackCanceledTasks.append(call.task)
                    }
                    Download4cj.withs().callbackDispatcher().endTasksWithCanceled(callbackCanceledTasks)
                }
            }
        }
    }