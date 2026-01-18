    private func readFileMode(file: Path, normalizedName: String): Unit {
        if (file.isDirectory()) {
            this.mode = TarArchiveEntry.DEFAULT_DIR_MODE
            this.linkFlag = TarConstants.LF_DIR
            let nameLength: Int64 = normalizedName.size
            if (nameLength == 0 || normalizedName[nameLength - 1] != '/') {
                this.name = normalizedName + "/"
            } else {
                this.name = normalizedName
            }
        } else {
            this.mode = TarArchiveEntry.DEFAULT_FILE_MODE
            this.linkFlag = TarConstants.LF_NORMAL
            this.name = normalizedName
            this.size = this.file[1].getOrThrow().length
        }
    }