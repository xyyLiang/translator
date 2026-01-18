    public func isDescendent(desc: TarArchiveEntry): Bool {
        return desc.getName().startsWith(this.getName())
    }