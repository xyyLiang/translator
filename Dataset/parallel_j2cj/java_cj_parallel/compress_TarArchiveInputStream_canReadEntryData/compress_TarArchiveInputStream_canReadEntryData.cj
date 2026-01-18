    public func canReadEntryData(ae: ArchiveEntry): Bool {
        return ae is TarArchiveEntry
    }