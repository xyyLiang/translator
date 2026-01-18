    @Deprecated
    public TarArchiveEntry getNextTarEntry() throws IOException {
        if (isAtEOF()) {
            return null;
        }

        if (currEntry != null) {
            /* Skip will only go to the end of the current entry */
            org.apache.commons.io.IOUtils.skip(this, Long.MAX_VALUE);

            /* skip to the end of the last record */
            skipRecordPadding();
        }

        final byte[] headerBuf = getRecord();

        if (headerBuf == null) {
            /* hit EOF */
            currEntry = null;
            return null;
        }

        try {
            currEntry = new TarArchiveEntry(globalPaxHeaders, headerBuf, zipEncoding, lenient);
        } catch (final IllegalArgumentException e) {
            throw new IOException("Error detected parsing the header", e);
        }

        entryOffset = 0;
        entrySize = currEntry.getSize();

        if (currEntry.isGNULongLinkEntry()) {
            final byte[] longLinkData = getLongNameData();
            if (longLinkData == null) {
                // Bugzilla: 40334
                // Malformed tar file - long link entry name not followed by
                // entry
                return null;
            }
            currEntry.setLinkName(zipEncoding.decode(longLinkData));
        }

        if (currEntry.isGNULongNameEntry()) {
            final byte[] longNameData = getLongNameData();
            if (longNameData == null) {
                // Bugzilla: 40334
                // Malformed tar file - long entry name not followed by
                // entry
                return null;
            }

            // COMPRESS-509 : the name of directories should end with '/'
            final String name = zipEncoding.decode(longNameData);
            currEntry.setName(name);
            if (currEntry.isDirectory() && !name.endsWith("/")) {
                currEntry.setName(name + "/");
            }
        }

        if (currEntry.isGlobalPaxHeader()) { // Process Global Pax headers
            readGlobalPaxHeaders();
        }

        try {
            if (currEntry.isPaxHeader()) { // Process Pax headers
                paxHeaders();
            } else if (!globalPaxHeaders.isEmpty()) {
                applyPaxHeadersToCurrentEntry(globalPaxHeaders, globalSparseHeaders);
            }
        } catch (final NumberFormatException e) {
            throw new IOException("Error detected parsing the pax header", e);
        }

        if (currEntry.isOldGNUSparse()) { // Process sparse files
            readOldGNUSparse();
        }

        // If the size of the next element in the archive has changed
        // due to a new size being reported in the posix header
        // information, we update entrySize here so that it contains
        // the correct value.
        entrySize = currEntry.getSize();

        return currEntry;
    }
