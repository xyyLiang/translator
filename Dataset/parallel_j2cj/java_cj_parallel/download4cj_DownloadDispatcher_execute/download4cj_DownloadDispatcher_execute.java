    public void execute(DownloadTask task) {
        Util.d(TAG, "execute: " + task);
        final DownloadCall call;

        synchronized (this) {
            if (inspectCompleted(task)) return;
            if (inspectForConflict(task)) return;

            call = DownloadCall.create(task, false, store);
            runningSyncCalls.add(call);
        }

        syncRunCall(call);
    }