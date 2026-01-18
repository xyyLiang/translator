    @Override
    public boolean isDirectory() {
        if (file != null) {
            return Files.isDirectory(file, linkOptions);
        }

        if (linkFlag == LF_DIR) {
            return true;
        }

        return !isPaxHeader() && !isGlobalPaxHeader() && getName().endsWith("/");
    }