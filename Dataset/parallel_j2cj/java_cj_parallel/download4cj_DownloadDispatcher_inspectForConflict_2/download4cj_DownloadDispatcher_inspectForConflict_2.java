    boolean inspectForConflict(@NonNull DownloadTask task,
                               @NonNull Collection<DownloadCall> calls,
                               @Nullable Collection<DownloadTask> sameTaskList,
                               @Nullable Collection<DownloadTask> fileBusyList) {
        final CallbackDispatcher callbackDispatcher = OkDownload.with().callbackDispatcher();
        final Iterator<DownloadCall> iterator = calls.iterator();
        while (iterator.hasNext()) {
            DownloadCall call = iterator.next();
            if (call.isCanceled()) continue;

            if (call.equalsTask(task)) {
                if (call.isFinishing()) {
                    Util.d(TAG, "task: " + task.getId()
                            + " is finishing, move it to finishing list");
                    finishingCalls.add(call);
                    iterator.remove();
                    return false;
                }

                if (sameTaskList != null) {
                    sameTaskList.add(task);
                } else {
                    callbackDispatcher.dispatch()
                            .taskEnd(task, EndCause.SAME_TASK_BUSY, null);
                }
                return true;
            }

            final File file = call.getFile();
            final File taskFile = task.getFile();
            if (file != null && taskFile != null && file.equals(taskFile)) {
                if (fileBusyList != null) {
                    fileBusyList.add(task);
                } else {
                    callbackDispatcher.dispatch().taskEnd(task, EndCause.FILE_BUSY, null);
                }
                return true;
            }
        }

        return false;
    }