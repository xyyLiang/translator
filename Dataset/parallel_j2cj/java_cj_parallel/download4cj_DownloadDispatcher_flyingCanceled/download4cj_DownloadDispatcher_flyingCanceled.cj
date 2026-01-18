    func flyingCanceled(call:DownloadCall):Unit{
        synchronized(m){
            Util.d(TAG, "flying canceled: " + call.task.getId().toString())
            if (call.asyncExecuted){
                flyingCanceledAsyncCallCount.fetchAdd(1)
            }
        }
    }