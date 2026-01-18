    @Override public void onSyncToFilesystemSuccess(@NonNull BreakpointInfo info, int blockIndex,
                                                    long increaseLength) throws IOException {
        final BreakpointInfo onCacheOne = this.storedInfos.get(info.id);
        if (info != onCacheOne) throw new IOException("Info not on store!");

        onCacheOne.getBlock(blockIndex).increaseCurrentOffset(increaseLength);
    }