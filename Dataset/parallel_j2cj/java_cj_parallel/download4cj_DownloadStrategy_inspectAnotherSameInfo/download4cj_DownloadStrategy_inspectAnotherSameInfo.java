    public boolean inspectAnotherSameInfo(@NonNull DownloadTask task, @NonNull BreakpointInfo info,
                                          long instanceLength) {
        if (!task.isFilenameFromResponse()) return false;

        final BreakpointStore store = OkDownload.with().breakpointStore();
        final BreakpointInfo anotherInfo = store.findAnotherInfoFromCompare(task, info);
        if (anotherInfo == null) return false;

        store.remove(anotherInfo.getId());

        if (anotherInfo.getTotalOffset()
                <= OkDownload.with().downloadStrategy().reuseIdledSameInfoThresholdBytes()) {
            return false;
        }

        if (anotherInfo.getEtag() != null && !anotherInfo.getEtag().equals(info.getEtag())) {
            return false;
        }

        if (anotherInfo.getTotalLength() != instanceLength) {
            return false;
        }

        if (anotherInfo.getFile() == null || !anotherInfo.getFile().exists()) return false;

        info.reuseBlocks(anotherInfo);

        Util.d(TAG, "Reuse another same info: " + info);
        return true;
    }