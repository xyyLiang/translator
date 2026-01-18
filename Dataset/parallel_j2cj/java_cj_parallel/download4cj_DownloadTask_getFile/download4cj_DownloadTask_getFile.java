    @Nullable public File getFile() {
        final String filename = filenameHolder.get();
        if (filename == null) return null;
        if (targetFile == null) targetFile = new File(directoryFile, filename);

        return targetFile;
    }