    public void check() throws IOException {
        // local etag
        final DownloadStrategy downloadStrategy = OkDownload.with().downloadStrategy();

        // execute trial
        ConnectTrial connectTrial = createConnectTrial();
        connectTrial.executeTrial();

        // single/multi
        final boolean isAcceptRange = connectTrial.isAcceptRange();
        final boolean isChunked = connectTrial.isChunked();
        // data
        final long instanceLength = connectTrial.getInstanceLength();
        final String responseEtag = connectTrial.getResponseEtag();
        final String responseFilename = connectTrial.getResponseFilename();
        final int responseCode = connectTrial.getResponseCode();

        // 1. assemble basic data.
        downloadStrategy.validFilenameFromResponse(responseFilename, task, info);
        info.setChunked(isChunked);
        info.setEtag(responseEtag);

        if (OkDownload.with().downloadDispatcher().isFileConflictAfterRun(task)) {
            throw FileBusyAfterRunException.SIGNAL;
        }

        // 2. collect result
        final ResumeFailedCause resumeFailedCause = downloadStrategy
                .getPreconditionFailedCause(responseCode, info.getTotalOffset() != 0, info,
                        responseEtag);

        this.resumable = resumeFailedCause == null;
        this.failedCause = resumeFailedCause;
        this.instanceLength = instanceLength;
        this.acceptRange = isAcceptRange;

        //3. check whether server cancelled.
        if (!isTrialSpecialPass(responseCode, instanceLength, resumable)
                && downloadStrategy.isServerCanceled(responseCode, info.getTotalOffset() != 0)) {
            throw new ServerCanceledException(responseCode, info.getTotalOffset());
        }
    }