    func cancelLocked(task:DownloadTask):Bool{
        synchronized(m){
            Util.d(TAG, "cancel manually: " + task.getId().toString())
            let needCallbackCalls:ArrayList<DownloadCall> = ArrayList<DownloadCall>()
            let needCancelCalls:ArrayList<DownloadCall> = ArrayList<DownloadCall>()
            try{
                filterCanceledCalls(task, needCallbackCalls, needCancelCalls)
            }finally{
                handleCanceledCalls(needCallbackCalls, needCancelCalls)
            }
            return needCallbackCalls.size > 0 || needCancelCalls.size > 0
        }
    }