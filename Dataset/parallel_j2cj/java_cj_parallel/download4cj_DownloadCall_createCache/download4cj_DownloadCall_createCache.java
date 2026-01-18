    DownloadCache createCache(@NonNull BreakpointInfo info) {
        final MultiPointOutputStream outputStream = OkDownload.with().processFileStrategy()
                .createProcessStream(task, info, store);
        return new DownloadCache(outputStream);
    }