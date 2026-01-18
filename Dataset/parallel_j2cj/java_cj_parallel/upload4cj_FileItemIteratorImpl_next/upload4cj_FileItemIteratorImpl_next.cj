    public override func next(): FileItemStream {
        let hsNext: Bool = hasNext()
        if (eof || (!itemValid && !hsNext)) {
            throw NoSuchElementException("No Such Element")
        }
        itemValid = false
        return currentItem.getOrThrow()
    }