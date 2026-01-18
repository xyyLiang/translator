    public void writeEntryHeader(final byte[] outbuf, final ZipEncoding encoding, final boolean starMode) throws IOException {
        int offset = 0;

        offset = TarUtils.formatNameBytes(name, outbuf, offset, NAMELEN, encoding);
        offset = writeEntryHeaderField(mode, outbuf, offset, MODELEN, starMode);
        offset = writeEntryHeaderField(userId, outbuf, offset, UIDLEN, starMode);
        offset = writeEntryHeaderField(groupId, outbuf, offset, GIDLEN, starMode);
        offset = writeEntryHeaderField(size, outbuf, offset, SIZELEN, starMode);
        offset = writeEntryHeaderField(TimeUtils.toUnixTime(mTime), outbuf, offset, MODTIMELEN, starMode);

        final int csOffset = offset;

        offset = fill((byte) ' ', offset, outbuf, CHKSUMLEN);

        outbuf[offset++] = linkFlag;
        offset = TarUtils.formatNameBytes(linkName, outbuf, offset, NAMELEN, encoding);
        offset = TarUtils.formatNameBytes(magic, outbuf, offset, MAGICLEN);
        offset = TarUtils.formatNameBytes(version, outbuf, offset, VERSIONLEN);
        offset = TarUtils.formatNameBytes(userName, outbuf, offset, UNAMELEN, encoding);
        offset = TarUtils.formatNameBytes(groupName, outbuf, offset, GNAMELEN, encoding);
        offset = writeEntryHeaderField(devMajor, outbuf, offset, DEVLEN, starMode);
        offset = writeEntryHeaderField(devMinor, outbuf, offset, DEVLEN, starMode);

        if (starMode) {
            // skip prefix
            offset = fill(0, offset, outbuf, PREFIXLEN_XSTAR);
            offset = writeEntryHeaderOptionalTimeField(aTime, offset, outbuf, ATIMELEN_XSTAR);
            offset = writeEntryHeaderOptionalTimeField(cTime, offset, outbuf, CTIMELEN_XSTAR);
            // 8-byte fill
            offset = fill(0, offset, outbuf, 8);
            // Do not write MAGIC_XSTAR because it causes issues with some TAR tools
            // This makes it effectively XUSTAR, which guarantees compatibility with USTAR
            offset = fill(0, offset, outbuf, XSTAR_MAGIC_LEN);
        }

        offset = fill(0, offset, outbuf, outbuf.length - offset); // NOSONAR - assignment as documentation

        final long chk = TarUtils.computeCheckSum(outbuf);

        TarUtils.formatCheckSumOctalBytes(chk, outbuf, csOffset, CHKSUMLEN);
    }
