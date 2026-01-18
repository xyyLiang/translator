    private void parseTarHeaderUnwrapped(final Map<String, String> globalPaxHeaders, final byte[] header, final ZipEncoding encoding, final boolean oldStyle,
            final boolean lenient) throws IOException {
        int offset = 0;

        name = oldStyle ? TarUtils.parseName(header, offset, NAMELEN) : TarUtils.parseName(header, offset, NAMELEN, encoding);
        offset += NAMELEN;
        mode = (int) parseOctalOrBinary(header, offset, MODELEN, lenient);
        offset += MODELEN;
        userId = (int) parseOctalOrBinary(header, offset, UIDLEN, lenient);
        offset += UIDLEN;
        groupId = (int) parseOctalOrBinary(header, offset, GIDLEN, lenient);
        offset += GIDLEN;
        size = TarUtils.parseOctalOrBinary(header, offset, SIZELEN);
        if (size < 0) {
            throw new IOException("broken archive, entry with negative size");
        }
        offset += SIZELEN;
        mTime = TimeUtils.unixTimeToFileTime(parseOctalOrBinary(header, offset, MODTIMELEN, lenient));
        offset += MODTIMELEN;
        checkSumOK = TarUtils.verifyCheckSum(header);
        offset += CHKSUMLEN;
        linkFlag = header[offset++];
        linkName = oldStyle ? TarUtils.parseName(header, offset, NAMELEN) : TarUtils.parseName(header, offset, NAMELEN, encoding);
        offset += NAMELEN;
        magic = TarUtils.parseName(header, offset, MAGICLEN);
        offset += MAGICLEN;
        version = TarUtils.parseName(header, offset, VERSIONLEN);
        offset += VERSIONLEN;
        userName = oldStyle ? TarUtils.parseName(header, offset, UNAMELEN) : TarUtils.parseName(header, offset, UNAMELEN, encoding);
        offset += UNAMELEN;
        groupName = oldStyle ? TarUtils.parseName(header, offset, GNAMELEN) : TarUtils.parseName(header, offset, GNAMELEN, encoding);
        offset += GNAMELEN;
        if (linkFlag == LF_CHR || linkFlag == LF_BLK) {
            devMajor = (int) parseOctalOrBinary(header, offset, DEVLEN, lenient);
            offset += DEVLEN;
            devMinor = (int) parseOctalOrBinary(header, offset, DEVLEN, lenient);
            offset += DEVLEN;
        } else {
            offset += 2 * DEVLEN;
        }

        final int type = evaluateType(globalPaxHeaders, header);
        switch (type) {
        case FORMAT_OLDGNU: {
            aTime = fileTimeFromOptionalSeconds(parseOctalOrBinary(header, offset, ATIMELEN_GNU, lenient));
            offset += ATIMELEN_GNU;
            cTime = fileTimeFromOptionalSeconds(parseOctalOrBinary(header, offset, CTIMELEN_GNU, lenient));
            offset += CTIMELEN_GNU;
            offset += OFFSETLEN_GNU;
            offset += LONGNAMESLEN_GNU;
            offset += PAD2LEN_GNU;
            sparseHeaders = new ArrayList<>(TarUtils.readSparseStructs(header, offset, SPARSE_HEADERS_IN_OLDGNU_HEADER));
            offset += SPARSELEN_GNU;
            isExtended = TarUtils.parseBoolean(header, offset);
            offset += ISEXTENDEDLEN_GNU;
            realSize = TarUtils.parseOctal(header, offset, REALSIZELEN_GNU);
            offset += REALSIZELEN_GNU; // NOSONAR - assignment as documentation
            break;
        }
        case FORMAT_XSTAR: {
            final String xstarPrefix = oldStyle ? TarUtils.parseName(header, offset, PREFIXLEN_XSTAR)
                    : TarUtils.parseName(header, offset, PREFIXLEN_XSTAR, encoding);
            offset += PREFIXLEN_XSTAR;
            if (!xstarPrefix.isEmpty()) {
                name = xstarPrefix + "/" + name;
            }
            aTime = fileTimeFromOptionalSeconds(parseOctalOrBinary(header, offset, ATIMELEN_XSTAR, lenient));
            offset += ATIMELEN_XSTAR;
            cTime = fileTimeFromOptionalSeconds(parseOctalOrBinary(header, offset, CTIMELEN_XSTAR, lenient));
            offset += CTIMELEN_XSTAR; // NOSONAR - assignment as documentation
            break;
        }
        case FORMAT_POSIX:
        default: {
            final String prefix = oldStyle ? TarUtils.parseName(header, offset, PREFIXLEN) : TarUtils.parseName(header, offset, PREFIXLEN, encoding);
            offset += PREFIXLEN; // NOSONAR - assignment as documentation
            // SunOS tar -E does not add / to directory names, so fix
            // up to be consistent
            if (isDirectory() && !name.endsWith("/")) {
                name += "/";
            }
            if (!prefix.isEmpty()) {
                name = prefix + "/" + name;
            }
        }
        }
    }
