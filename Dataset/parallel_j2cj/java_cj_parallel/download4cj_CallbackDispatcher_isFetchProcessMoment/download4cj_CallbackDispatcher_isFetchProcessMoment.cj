   func isFetchProcessMoment(task:DownloadTask):Bool{
        let minInterval:Int64 = task.getMinIntervalMillisCallbackProcess()


        let now:Int64 = DateTime.now().toUnixTimeStamp().toNanoseconds()

        return (minInterval <= 0) || ((now - TaskHideWrapper.getLastCallbackProcessTs(task)) >= minInterval)
   }