    public static void assembleBlock(@NonNull DownloadTask task, @NonNull BreakpointInfo info,
                                     long instanceLength,
                                     boolean isAcceptRange) {
        final int blockCount;
        if (OkDownload.with().downloadStrategy().isUseMultiBlock(isAcceptRange)) {
            blockCount = OkDownload.with().downloadStrategy()
                    .determineBlockCount(task, instanceLength);
        } else {
            blockCount = 1;
        }

        info.resetBlockInfos();
        final long eachLength = instanceLength / blockCount;
        long startOffset = 0;
        long contentLength = 0;
        for (int i = 0; i < blockCount; i++) {
            startOffset = startOffset + contentLength;
            if (i == 0) {
                // first block
                final long remainLength = instanceLength % blockCount;
                contentLength = eachLength + remainLength;
            } else {
                contentLength = eachLength;
            }

            final BlockInfo blockInfo = new BlockInfo(startOffset, contentLength);
            info.addBlock(blockInfo);
        }
    }