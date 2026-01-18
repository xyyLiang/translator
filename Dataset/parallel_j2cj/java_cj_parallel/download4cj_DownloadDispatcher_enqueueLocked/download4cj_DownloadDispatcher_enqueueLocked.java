    private synchronized void enqueueLocked(DownloadTask[] tasks) {
        final long startTime = SystemClock.uptimeMillis();
        Util.d(TAG, "start enqueueLocked for bunch task: " + tasks.length);
        final List<DownloadTask> taskList = new ArrayList<>();
        Collections.addAll(taskList, tasks);
        if (taskList.size() > 1) Collections.sort(taskList);

        final int originReadyAsyncCallSize = readyAsyncCalls.size();
        try {
            OkDownload.with().downloadStrategy().inspectNetworkAvailable();

            final Collection<DownloadTask> completedTaskList = new ArrayList<>();
            final Collection<DownloadTask> sameTaskConflictList = new ArrayList<>();
            final Collection<DownloadTask> fileBusyList = new ArrayList<>();
            for (DownloadTask task : taskList) {
                if (inspectCompleted(task, completedTaskList)) continue;
                if (inspectForConflict(task, sameTaskConflictList, fileBusyList)) continue;

                enqueueIgnorePriority(task);
            }
            OkDownload.with().callbackDispatcher()
                    .endTasks(completedTaskList, sameTaskConflictList, fileBusyList);

        } catch (UnknownHostException e) {
            final Collection<DownloadTask> errorList = new ArrayList<>(taskList);
            OkDownload.with().callbackDispatcher().endTasksWithError(errorList, e);
        }
        if (originReadyAsyncCallSize != readyAsyncCalls.size()) Collections.sort(readyAsyncCalls);

        Util.d(TAG, "end enqueueLocked for bunch task: " + tasks.length + " consume "
                + (SystemClock.uptimeMillis() - startTime) + "ms");
    }