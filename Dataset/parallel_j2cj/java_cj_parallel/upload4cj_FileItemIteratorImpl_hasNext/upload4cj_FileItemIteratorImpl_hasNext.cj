    public override func hasNext(): Bool {
        if (eof) {
            return false
        }

        if (itemValid) {
            return true
        }

        try {
            return findNextItem()
        } catch (e: FileUploadException) {
            throw FileUploadException("FindNextItem Fail")
        }
    }
