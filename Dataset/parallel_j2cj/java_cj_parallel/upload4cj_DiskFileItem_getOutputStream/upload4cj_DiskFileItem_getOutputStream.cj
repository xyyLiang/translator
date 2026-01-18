    public override func getOutputStream(): OutputStream {
        let isDfos = match (dfos) {
            case Some(_) => true
            case None => false
        }
        if (!isDfos) {
            dfos = DeferredFileOutputStream(sizeThreshold, tempFile, repository)
        }

        return dfos.getOrThrow()
    }