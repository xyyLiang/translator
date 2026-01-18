    public override func getNextEntry(): ?ArchiveEntry {
        return match(this.getNextTarEntry()) {
            case None => None
            case Some(v) => Option<ArchiveEntry>.Some(v)
        }
    }