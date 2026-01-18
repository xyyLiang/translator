    private func enqueueIgnorePriority(task:DownloadTask):Unit{
        let call:DownloadCall = DownloadCall.create(task, true, store.getOrThrow())
        if (runningAsyncSize() < maxParallelRunningCount) {
            runningAsyncCalls.append(call)
            spawn{=>
                try{
                    call.executeCall()
                }finally{
                    finish(call)
                }
            }
        } else {
            readyAsyncCalls.append(call)
        }
    }