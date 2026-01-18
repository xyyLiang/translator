    private func cancelLocked(tasks:Array<DownloadTask>):Unit{
        synchronized(m){
            let startCancelTime:Int64 = DateTime.now().toUnixTimeStamp().toNanoseconds()/1000/1000
            Util.d(TAG, "start cancel bunch task manually: " + tasks.size.toString())
            let needCallbackCalls:ArrayList<DownloadCall> = ArrayList<DownloadCall>()
            let needCancelCalls:ArrayList<DownloadCall> = ArrayList<DownloadCall>()
            try {
                for (task in tasks) {
                    filterCanceledCalls(task, needCallbackCalls, needCancelCalls)
                }
            }finally{
                handleCanceledCalls(needCallbackCalls, needCancelCalls)
                 let endCancelTime:Int64 = DateTime.now().toUnixTimeStamp().toNanoseconds()/1000/1000
                Util.d(TAG,"finish cancel bunch task manually: " + tasks.size.toString() + " consume "+(endCancelTime - startCancelTime).toString() + "ms")
            }
        }
    }