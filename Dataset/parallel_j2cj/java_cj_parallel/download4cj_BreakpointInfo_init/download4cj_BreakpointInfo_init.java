    public BreakpointInfo(int id, @NonNull String url, @NonNull File parentFile,
                          @Nullable String filename) {
        this.id = id;
        this.url = url;
        this.parentFile = parentFile;
        this.blockInfoList = new ArrayList<>();

        if (Util.isEmpty(filename)) {
            filenameHolder = new DownloadStrategy.FilenameHolder();
            taskOnlyProvidedParentPath = true;
        } else {
            filenameHolder = new DownloadStrategy.FilenameHolder(filename);
            taskOnlyProvidedParentPath = false;
            targetFile = new File(parentFile, filename);
        }
    }