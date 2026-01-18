    func execute(task:DownloadTask):Unit{
        let call:DownloadCall
        synchronized (m) {
            if (inspectCompleted()) {
                return
            }

            if (inspectForConflict(task)){
                return
            }

            call = DownloadCall.create(task, false, store.getOrThrow())
            runningSyncCalls.append(call)
        }
        try{
            call.executeCall()
        }finally{
            finish(call)
        }
    }