    public override func getInputStream(): Option<InputStream> {
        if (!this.isInMemory()) {
            let optFile: Option<File> = this.dfos.getOrThrow().getFile()
            if (let Some(j) <- optFile) {
                return j
            } else {
                return Option<InputStream>.None
            }
        } else {
            if (let Some(_) <- cachedContent) {}
            else {
                cachedContent = this.dfos.getOrThrow().getData()
            }
            var b = ByteArrayStream()
            b.write(this.cachedContent.getOrThrow())
            return b
        }
    }