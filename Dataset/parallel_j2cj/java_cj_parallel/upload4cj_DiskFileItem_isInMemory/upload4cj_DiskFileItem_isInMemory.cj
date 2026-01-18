    public override func isInMemory(): Bool {
        if (let Some(_) <- cachedContent) {
            return true
        }
        return this.dfos.getOrThrow().isInMemory()
    }