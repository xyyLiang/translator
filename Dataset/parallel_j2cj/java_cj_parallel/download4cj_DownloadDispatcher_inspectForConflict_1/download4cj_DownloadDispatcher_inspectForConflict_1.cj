    private func inspectForConflict(task:DownloadTask,sameTaskList:Option<ArrayList<DownloadTask>>,fileBusyList:Option<ArrayList<DownloadTask>>){
        let resultA = inspectForConflict(task, readyAsyncCalls, sameTaskList, fileBusyList)
        let resultB = inspectForConflict(task, runningAsyncCalls, sameTaskList, fileBusyList)
        let resultC = inspectForConflict(task, runningSyncCalls, sameTaskList, fileBusyList)
        return resultA||resultB||resultC
    }