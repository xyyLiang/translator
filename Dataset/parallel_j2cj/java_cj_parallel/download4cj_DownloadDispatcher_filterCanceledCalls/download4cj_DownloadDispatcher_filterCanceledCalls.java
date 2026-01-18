    private synchronized void filterCanceledCalls(@NonNull IdentifiedTask task,
                                                  @NonNull List<DownloadCall> needCallbackCalls,
                                                  @NonNull List<DownloadCall> needCancelCalls) {
        for (Iterator<DownloadCall> i = readyAsyncCalls.iterator(); i.hasNext(); ) {
            DownloadCall call = i.next();
            if (call.task == task || call.task.getId() == task.getId()) {
                if (call.isCanceled() || call.isFinishing()) return;

                i.remove();
                needCallbackCalls.add(call);
                return;
            }
        }

        for (DownloadCall call : runningAsyncCalls) {
            if (call.task == task || call.task.getId() == task.getId()) {
                needCallbackCalls.add(call);
                needCancelCalls.add(call);
                return;
            }
        }

        for (DownloadCall call : runningSyncCalls) {
            if (call.task == task || call.task.getId() == task.getId()) {
                needCallbackCalls.add(call);
                needCancelCalls.add(call);
                return;
            }
        }
    }