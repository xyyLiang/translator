    @Override
    public boolean canReadEntryData(final ArchiveEntry ae) {
        return ae instanceof TarArchiveEntry;
    }