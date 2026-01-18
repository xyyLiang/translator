    public override func getSize(): Int64 {
        if (this.size >= 0) {
            return this.size
        }

        let InMemory = match (cachedContent) {
            case Some(_) => this.cachedContent.getOrThrow().size
            case None => 0
        }

        if (InMemory != 0) {
            return InMemory
        }

        if (this.dfos.getOrThrow().isInMemory()) {
            return this.dfos.getOrThrow().getData().getOrThrow().size
        }

        let optFile = this.dfos.getOrThrow().getFile()
        if (let Some(i) <- optFile) {
            return i.info.length
        } else {
            return 0
        }
    }