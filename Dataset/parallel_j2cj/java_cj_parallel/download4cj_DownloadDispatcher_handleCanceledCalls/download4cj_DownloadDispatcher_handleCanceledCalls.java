    private synchronized void handleCanceledCalls(@NonNull List<DownloadCall> needCallbackCalls,
                                                  @NonNull List<DownloadCall> needCancelCalls) {
        Util.d(TAG, "handle cancel calls, cancel calls: " + needCancelCalls.size());
        if (!needCancelCalls.isEmpty()) {
            for (DownloadCall call : needCancelCalls) {
                if (!call.cancel()) {
                    needCallbackCalls.remove(call);
                }
            }
        }

        Util.d(TAG, "handle cancel calls, callback cancel event: " + needCallbackCalls.size());
        if (!needCallbackCalls.isEmpty()) {
            if (needCallbackCalls.size() <= 1) {
                final DownloadCall call = needCallbackCalls.get(0);
                OkDownload.with().callbackDispatcher().dispatch().taskEnd(call.task,
                        EndCause.CANCELED,
                        null);
            } else {
                List<DownloadTask> callbackCanceledTasks = new ArrayList<>();
                for (DownloadCall call : needCallbackCalls) {
                    callbackCanceledTasks.add(call.task);
                }
                OkDownload.with().callbackDispatcher().endTasksWithCanceled(callbackCanceledTasks);
            }
        }
    }