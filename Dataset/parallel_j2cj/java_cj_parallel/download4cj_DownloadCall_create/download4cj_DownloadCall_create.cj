    static func create(task:DownloadTask,asyncExecuted:Bool,store:DownloadStore){
        return DownloadCall(task, asyncExecuted, store)
    }