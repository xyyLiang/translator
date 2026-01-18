    public ResumeAvailableResponseCheck resumeAvailableResponseCheck(
            DownloadConnection.Connected connected,
            int blockIndex,
            BreakpointInfo info) {
        return new ResumeAvailableResponseCheck(connected, blockIndex, info);
    }