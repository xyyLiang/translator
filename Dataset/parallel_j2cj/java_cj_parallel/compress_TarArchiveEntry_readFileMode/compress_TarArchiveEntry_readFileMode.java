    private void readFileMode(final Path file, final String normalizedName, final LinkOption... options) throws IOException {
        if (Files.isDirectory(file, options)) {
            this.mode = DEFAULT_DIR_MODE;
            this.linkFlag = LF_DIR;

            final int nameLength = normalizedName.length();
            if (nameLength == 0 || normalizedName.charAt(nameLength - 1) != '/') {
                this.name = normalizedName + "/";
            } else {
                this.name = normalizedName;
            }
        } else {
            this.mode = DEFAULT_FILE_MODE;
            this.linkFlag = LF_NORMAL;
            this.name = normalizedName;
            this.size = Files.size(file);
        }
    }