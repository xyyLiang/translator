    public boolean isFile() {
        if (file != null) {
            return Files.isRegularFile(file, linkOptions);
        }
        if (linkFlag == LF_OLDNORM || linkFlag == LF_NORMAL) {
            return true;
        }
        return linkFlag != LF_DIR && !getName().endsWith("/");
    }