    public boolean isDescendent(final TarArchiveEntry desc) {
        return desc.getName().startsWith(getName());
    }