public boolean cancel() {
    synchronized (this) {
        if (canceled) return false;
        if (finishing) return false;
        this.canceled = true;
    }

    final long startCancelTime = SystemClock.uptimeMillis();

    OkDownload.with().downloadDispatcher().flyingCanceled(this);

    final DownloadCache cache = this.cache;
    if (cache != null) cache.setUserCanceled();

    final Object[] chains = blockChainList.toArray();
    if (chains == null || chains.length == 0) {
        if (currentThread != null) {
            Util.d(TAG,
                    "interrupt thread with cancel operation because of chains are not running "
                            + task.getId());
            currentThread.interrupt();
        }
    } else {
        for (Object chain : chains) {
            if (chain instanceof DownloadChain) {
                ((DownloadChain) chain).cancel();
            }
        }
    }

    if (cache != null) cache.getOutputStream().cancelAsync();

    Util.d(TAG, "cancel task " + task.getId() + " consume: " + (SystemClock
            .uptimeMillis() - startCancelTime) + "ms");
    return true;
}