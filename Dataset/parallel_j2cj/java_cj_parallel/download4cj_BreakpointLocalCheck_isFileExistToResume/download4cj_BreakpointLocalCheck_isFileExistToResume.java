    public boolean isFileExistToResume() {
        final Uri uri = task.getUri();
        if (Util.isUriContentScheme(uri)) {
            return Util.getSizeFromContentUri(uri) > 0;
        } else {
            final File file = task.getFile();
            return file != null && file.exists();
        }
    }