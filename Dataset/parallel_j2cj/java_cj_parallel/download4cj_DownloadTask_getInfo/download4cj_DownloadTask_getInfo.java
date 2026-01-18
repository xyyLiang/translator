    @Nullable public BreakpointInfo getInfo() {
        if (info == null) info = OkDownload.with().breakpointStore().get(id);
        return info;
    }