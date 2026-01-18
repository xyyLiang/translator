    public func writeEntryHeader(outbuf: Array<Byte>, encoding: ZipEncoding, starMode: Bool): Unit {
        var offset: Int64 = 0
        offset = TarUtils.formatNameBytes(name, outbuf, offset, NAMELEN, encoding)
        offset = writeEntryHeaderField(mode, outbuf, offset, MODELEN, starMode)
        offset = writeEntryHeaderField(userId, outbuf, offset, UIDLEN, starMode)
        offset = writeEntryHeaderField(groupId, outbuf, offset, GIDLEN, starMode)
        offset = writeEntryHeaderField(size, outbuf, offset, SIZELEN, starMode)
        offset = writeEntryHeaderField(this.modTime, outbuf, offset, MODTIMELEN, starMode)

        let csOffset = offset

        offset = fill(UInt8(UInt32(' ')), offset, outbuf, CHKSUMLEN)

        outbuf[offset] = linkFlag
        offset++
        offset = TarUtils.formatNameBytes(linkName, outbuf, offset, NAMELEN, encoding)
        offset = TarUtils.formatNameBytes(magic, outbuf, offset, MAGICLEN)
        offset = TarUtils.formatNameBytes(version, outbuf, offset, VERSIONLEN)
        offset = TarUtils.formatNameBytes(userName, outbuf, offset, UNAMELEN, encoding)
        offset = TarUtils.formatNameBytes(groupName, outbuf, offset, GNAMELEN, encoding)
        offset = writeEntryHeaderField(devMajor, outbuf, offset, DEVLEN, starMode)
        offset = writeEntryHeaderField(devMinor, outbuf, offset, DEVLEN, starMode)

        if (starMode) {
            // skip prefix
            offset = fill(0, offset, outbuf, PREFIXLEN_XSTAR)
            offset = writeEntryHeaderOptionalTimeField(aTime, offset, outbuf, ATIMELEN_XSTAR)
            offset = writeEntryHeaderOptionalTimeField(cTime, offset, outbuf, CTIMELEN_XSTAR)
            // 8-byte fill
            offset = fill(0, offset, outbuf, 8)
            // Do not write MAGIC_XSTAR because it causes issues with some TAR tools
            // This makes it effectively XUSTAR, which guarantees compatibility with USTAR
            offset = fill(0, offset, outbuf, XSTAR_MAGIC_LEN)
        }
        offset = fill(0, offset, outbuf, outbuf.size - offset) // NOSONAR - assignment as documentation
        let chk: Int64 = TarUtils.computeCheckSum(outbuf)
        TarUtils.formatCheckSumOctalBytes(chk, outbuf, csOffset, TarConstants.CHKSUMLEN)
    }