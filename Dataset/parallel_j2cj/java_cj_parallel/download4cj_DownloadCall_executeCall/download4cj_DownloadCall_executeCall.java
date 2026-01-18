    @Override
    public void execute() throws InterruptedException {
        currentThread = Thread.currentThread();

        boolean retry;
        int retryCount = 0;

        // ready param
        final OkDownload okDownload = OkDownload.with();
        final ProcessFileStrategy fileStrategy = okDownload.processFileStrategy();

        // inspect task start
        inspectTaskStart();
        do {
            // 0. check basic param before start
            if (task.getUrl().length() <= 0) {
                this.cache = new DownloadCache.PreError(
                        new IOException("unexpected url: " + task.getUrl()));
                break;
            }

            if (canceled) break;

            // 1. create basic info if not exist
            @NonNull final BreakpointInfo info;
            try {
                BreakpointInfo infoOnStore = store.get(task.getId());
                if (infoOnStore == null) {
                    info = store.createAndInsert(task);
                } else {
                    info = infoOnStore;
                }
                setInfoToTask(info);
            } catch (IOException e) {
                this.cache = new DownloadCache.PreError(e);
                break;
            }
            if (canceled) break;

            // ready cache.
            @NonNull final DownloadCache cache = createCache(info);
            this.cache = cache;

            // 2. remote check.
            final BreakpointRemoteCheck remoteCheck = createRemoteCheck(info);
            try {
                remoteCheck.check();
            } catch (IOException e) {
                cache.catchException(e);
                break;
            }
            cache.setRedirectLocation(task.getRedirectLocation());

            // 3. waiting for file lock release after file path is confirmed.
            fileStrategy.getFileLock().waitForRelease(task.getFile().getAbsolutePath());

            // 4. reuse another info if another info is idle and available for reuse.
            OkDownload.with().downloadStrategy()
                    .inspectAnotherSameInfo(task, info, remoteCheck.getInstanceLength());

            try {
                if (remoteCheck.isResumable()) {
                    // 5. local check
                    final BreakpointLocalCheck localCheck = createLocalCheck(info,
                            remoteCheck.getInstanceLength());
                    localCheck.check();
                    if (localCheck.isDirty()) {
                        Util.d(TAG, "breakpoint invalid: download from beginning because of "
                                + "local check is dirty " + task.getId() + " " + localCheck);
                        // 6. assemble block data
                        fileStrategy.discardProcess(task);
                        assembleBlockAndCallbackFromBeginning(info, remoteCheck,
                                localCheck.getCauseOrThrow());
                    } else {
                        okDownload.callbackDispatcher().dispatch()
                                .downloadFromBreakpoint(task, info);
                    }
                } else {
                    Util.d(TAG, "breakpoint invalid: download from beginning because of "
                            + "remote check not resumable " + task.getId() + " " + remoteCheck);
                    // 6. assemble block data
                    fileStrategy.discardProcess(task);
                    assembleBlockAndCallbackFromBeginning(info, remoteCheck,
                            remoteCheck.getCauseOrThrow());
                }
            } catch (IOException e) {
                cache.setUnknownError(e);
                break;
            }

            // 7. start with cache and info.
            start(cache, info);

            if (canceled) break;

            // 8. retry if precondition failed.
            if (cache.isPreconditionFailed()
                    && retryCount++ < MAX_COUNT_RETRY_FOR_PRECONDITION_FAILED) {
                store.remove(task.getId());
                retry = true;
            } else {
                retry = false;
            }
        } while (retry);

        // finish
        finishing = true;
        blockChainList.clear();

        final DownloadCache cache = this.cache;
        if (canceled || cache == null) return;

        final EndCause cause;
        Exception realCause = null;
        if (cache.isServerCanceled() || cache.isUnknownError()
                || cache.isPreconditionFailed()) {
            // error
            cause = EndCause.ERROR;
            realCause = cache.getRealCause();
        } else if (cache.isFileBusyAfterRun()) {
            cause = EndCause.FILE_BUSY;
        } else if (cache.isPreAllocateFailed()) {
            cause = EndCause.PRE_ALLOCATE_FAILED;
            realCause = cache.getRealCause();
        } else {
            cause = EndCause.COMPLETED;
        }
        inspectTaskEnd(cache, cause, realCause);
    }