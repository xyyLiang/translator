    @SuppressWarnings("unchecked")
    @Override
    public R upFile(File file) {
        this.file = file;
        this.mediaType = HttpUtils.guessMimeType(file.getName());
        return (R) this;
    }