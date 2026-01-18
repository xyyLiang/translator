    public override func delete() {
        cachedContent = Option<Array<UInt8>>.None
        var outputFile: Option<File> = getStoreLocation()

        let isOutputFile = match (outputFile) {
            case Some(v) =>
                v.close()
                true
            case None => false
        }

        if (isOutputFile && File.exists(outputFile.getOrThrow().info.path)) {
            File.delete(outputFile.getOrThrow().info.path)
        }
    }