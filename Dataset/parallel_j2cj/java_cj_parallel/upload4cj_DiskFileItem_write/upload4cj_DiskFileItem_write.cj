    public override func write(file: File) {
        if (isInMemory()) {
            try {
                file.write(get().getOrThrow())
            } catch (ie: FSException) {
                throw ParseException("fail to write")
            }
        } else {
            var outputFile: Option<File> = getStoreLocation()

            let isOutputFile = match (outputFile) {
                case Some(_) => true
                case None => false
            }

            if (isOutputFile) {
                // Save the length of the file
                size = outputFile.getOrThrow().info.length
                file.write(get().getOrThrow())
                /*
                 * The uploaded file is being stored on disk
                 * in a temporary location so move it to the
                 * desired file.
                 */
                // FileUtils.moveFile(outputFile, file)
            } else {
                /*
                 * For whatever reason we cannot write the
                 * file to disk.
                 */
                throw FileUploadException("Cannot write uploaded file to disk!")
            }
        }

        return
    }