    private func enqueueLocked(task:DownloadTask):Unit{
        synchronized(m){
            if (inspectCompleted()){
                return
            }

            if (inspectForConflict(task)){
                return
            }

            let originReadyAsyncCallSize:Int64 = readyAsyncCalls.size
            enqueueIgnorePriority(task)
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