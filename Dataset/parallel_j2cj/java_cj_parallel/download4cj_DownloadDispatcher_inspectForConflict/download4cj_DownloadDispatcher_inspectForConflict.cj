    private func inspectForConflict(task:DownloadTask):Bool{
        return inspectForConflict(task,Option<ArrayList<DownloadTask>>.None,Option<ArrayList<DownloadTask>>.None)
    }
