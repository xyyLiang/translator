    public boolean compareIgnoreId(IdentifiedTask another) {
        if (!getUrl().equals(another.getUrl())) return false;

        if (getUrl().equals(EMPTY_URL) || getParentFile().equals(EMPTY_FILE)) return false;

        if (getProvidedPathFile().equals(another.getProvidedPathFile())) return true;

        if (!getParentFile().equals(another.getParentFile())) return false;

        // cover the case of filename is provided by response.
        final String filename = getFilename();
        final String anotherFilename = another.getFilename();
        return anotherFilename != null && filename != null && anotherFilename.equals(filename);
    }