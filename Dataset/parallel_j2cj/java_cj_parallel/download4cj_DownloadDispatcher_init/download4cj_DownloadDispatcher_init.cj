    init(readyAsyncCalls:ArrayList<DownloadCall>,runningAsyncCalls:ArrayList<DownloadCall>,
                runningSyncCalls:ArrayList<DownloadCall>,finishingCalls:ArrayList<DownloadCall>){
        this.readyAsyncCalls = readyAsyncCalls
        this.runningAsyncCalls = runningAsyncCalls
        this.runningSyncCalls = runningSyncCalls
        this.finishingCalls = finishingCalls
        this.store = Option<DownloadStore>.None
    }
