    public boolean isUseMultiBlock(final boolean isAcceptRange) {

        // output stream not support seek
        if (!OkDownload.with().outputStreamFactory().supportSeek()) return false;

        //  support range
        return isAcceptRange;
    }
