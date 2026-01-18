    @Override
    public boolean update(@NonNull BreakpointInfo breakpointInfo) {
        final String filename = breakpointInfo.getFilename();
        if (breakpointInfo.isTaskOnlyProvidedParentPath() && filename != null) {
            this.responseFilenameMap.put(breakpointInfo.getUrl(), filename);
        }

        final BreakpointInfo onCacheOne = this.storedInfos.get(breakpointInfo.id);
        if (onCacheOne != null) {
            if (onCacheOne == breakpointInfo) return true;

            // replace
            synchronized (this) {
                this.storedInfos.put(breakpointInfo.id, breakpointInfo.copy());
            }
            return true;
        }

        return false;
    }