    public func getNextTarEntry(): ?TarArchiveEntry {
        if (this.isAtEOF()) {
            return None
        }
        match (this.currEntry) {
            case None => ()
            case _ => 
                skip(this, currEntry.getOrThrow().getRealSize() - entryOffset)
                this.skipRecordPadding()
        }
        let headerBuf: ?Array<Byte> = this.getRecord()
        match (headerBuf) {
            case None => 
                this.currEntry = None
                return None
            case _ => ()
        }
        try {
            this.currEntry = TarArchiveEntry()
            this.currEntry.getOrThrow().tarArchiveEntryBuf(headerBuf.getOrThrow(), this.zipEncoding, this.lenient)
        } catch (e: Exception) {
            throw Exception("Error detected parsing the header")
        }
        this.entryOffset = 0
        this.entrySize = this.currEntry.getOrThrow().getSize()

        if (this.currEntry.getOrThrow().isGNULongLinkEntry()) {
            let longLinkData: ?Array<Byte> = this.getLongNameData()
            if (longLinkData == None) {
                return None
            }
            this.currEntry.getOrThrow().setLinkName(this.zipEncoding.decode(longLinkData.getOrThrow()))
        }
        if (this.currEntry.getOrThrow().isGNULongNameEntry()) {
            let longNameData: ?Array<Byte> = this.getLongNameData()
            match (longNameData) {
                case None => return None
                case _ => ()
            }

            let name: String = this.zipEncoding.decode(longNameData.getOrThrow())
            this.currEntry.getOrThrow().setName(name)
            if (this.currEntry.getOrThrow().isDirectory() && !name.endsWith("/")) {
                this.currEntry.getOrThrow().setName(name + "/")
            }
        }
        if (this.currEntry.getOrThrow().isGlobalPaxHeader()) {
            this.readGlobalPaxHeaders()
        }
        try {
            if (this.currEntry.getOrThrow().isPaxHeader()) {
                this.paxHeaders()
            } else if (this.globalPaxHeaders.size != 0) {
                this.applyPaxHeadersToCurrentEntry(this.globalPaxHeaders, this.globalSparseHeaders)
            }
        } catch (e: Exception) {
            throw Exception("Error detected parsing the pax header")
        }
        if (this.currEntry.getOrThrow().isOldGNUSparse()) {
            this.readOldGNUSparse()
        }
        this.entrySize = this.currEntry.getOrThrow().getSize()
        return this.currEntry
    }