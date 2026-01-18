    public func getStoreLocation(): Option<File> {
        let isDfos = match (dfos) {
            case Some(_) => true
            case None => false
        }

        if (!isDfos) {
            return Option<File>.None
        }

        let fileName: Option<File> = dfos.getOrThrow().getFile()
        return fileName
    }