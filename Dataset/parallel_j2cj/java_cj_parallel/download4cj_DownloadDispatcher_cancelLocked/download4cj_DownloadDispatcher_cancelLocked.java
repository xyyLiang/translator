private synchronized void cancelLocked(IdentifiedTask[] tasks) {
    final long startCancelTime = SystemClock.uptimeMillis();
    Util.d(TAG, "start cancel bunch task manually: " + tasks.length);

    final List<DownloadCall> needCallbackCalls = new ArrayList<>();
    final List<DownloadCall> needCancelCalls = new ArrayList<>();
    try {
        for (IdentifiedTask task : tasks) {
            filterCanceledCalls(task, needCallbackCalls, needCancelCalls);
        }
    } finally {
        handleCanceledCalls(needCallbackCalls, needCancelCalls);
        Util.d(TAG,
                "finish cancel bunch task manually: " + tasks.length + " consume "
                        + (SystemClock.uptimeMillis() - startCancelTime) + "ms");
    }
}