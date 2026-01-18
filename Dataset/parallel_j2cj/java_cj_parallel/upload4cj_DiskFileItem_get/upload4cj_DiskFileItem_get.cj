    public override func get(): Option<Array<UInt8>> {
        if (this.isInMemory()) {
            let isCachedContent = match (cachedContent) {
                case Some(_) => true
                case None => false
            }

            let isDfos = match (dfos) {
                case Some(_) => true
                case None => false
            }

            if (!isCachedContent && isDfos) {
                this.cachedContent = this.dfos.getOrThrow().getData()
            }
            return this.cachedContent
        }

        var fileData: Option<Array<UInt8>> = Array<UInt8>(this.getSize(), item: 0)

        // read file to Array<Unit8>
        try {
            //如果close了，就不能调用seek和read了所以用这种代替
            let file = File(this.dfos.getOrThrow().getFile().getOrThrow().info.path, OpenOption.Open(true,true))
            file.seek(SeekPosition.Begin(0))
            file.read(fileData.getOrThrow())
        } catch (ie: Exception) {
            return Option<Array<UInt8>>.None
        }
        return fileData
    }