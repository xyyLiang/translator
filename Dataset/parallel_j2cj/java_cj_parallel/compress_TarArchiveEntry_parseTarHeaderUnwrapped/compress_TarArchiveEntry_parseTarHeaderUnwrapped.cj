    private func parseTarHeaderUnwrapped(header: Array<Byte>, encoding: ZipEncoding, oldStyle: Bool, lenient: Bool): Unit {
        var offset: Int64 = 0
        this.name = if (oldStyle) {
            TarUtils.parseName(header, offset, TarConstants.NAMELEN)
        } else {
            TarUtils.parseNameEncoding(header, offset, TarConstants.NAMELEN, encoding)
        }
        offset += TarConstants.NAMELEN
        this.mode = this.parseOctalOrBinary(header, offset, TarConstants.MODELEN, lenient)
        offset += TarConstants.MODELEN
        this.userId = this.parseOctalOrBinary(header, offset, TarConstants.UIDLEN, lenient)
        offset += TarConstants.UIDLEN
        this.groupId = this.parseOctalOrBinary(header, offset, TarConstants.GIDLEN, lenient)
        offset += TarConstants.GIDLEN
        this.size = TarUtils.parseOctalOrBinary(header, offset, TarConstants.SIZELEN)
        if (this.size < 0) {
            throw  Exception("broken archive, entry with negative size")
        }
        offset += TarConstants.SIZELEN
        this.modTime = this.parseOctalOrBinary(header, offset, TarConstants.MODTIMELEN, lenient)
        offset += TarConstants.MODTIMELEN
        this.checkSumOK = TarUtils.verifyCheckSum(header)
        offset += TarConstants.CHKSUMLEN
        this.linkFlag = header[offset]
        offset++
        this.linkName = if (oldStyle) {
            TarUtils.parseName(header, offset, TarConstants.NAMELEN)
        } else {
            TarUtils.parseNameEncoding(header, offset, TarConstants.NAMELEN, encoding)
        }
        offset += TarConstants.NAMELEN
        this.magic = TarUtils.parseName(header, offset, TarConstants.MAGICLEN)
        offset += TarConstants.MAGICLEN
        this.version = TarUtils.parseName(header, offset, TarConstants.VERSIONLEN)
        offset += TarConstants.VERSIONLEN
        this.userName = if (oldStyle) {
            TarUtils.parseName(header, offset, TarConstants.UNAMELEN)
        } else {
            TarUtils.parseNameEncoding(header, offset, TarConstants.UNAMELEN, encoding)
        }
        offset += TarConstants.UNAMELEN
        this.groupName = if (oldStyle) {
            TarUtils.parseName(header, offset, TarConstants.GNAMELEN)
        } else {
            TarUtils.parseNameEncoding(header, offset, TarConstants.GNAMELEN, encoding)
        }
        offset += TarConstants.GNAMELEN
        if (this.linkFlag == TarConstants.LF_CHR || this.linkFlag == TarConstants.LF_BLK) {
            this.devMajor = this.parseOctalOrBinary(header, offset, TarConstants.DEVLEN, lenient)
            offset += TarConstants.DEVLEN
            this.devMinor = this.parseOctalOrBinary(header, offset, TarConstants.DEVLEN, lenient)
            offset += TarConstants.DEVLEN
        } else {
            offset += 2 * TarConstants.DEVLEN
        }

        let types: Int64 = this.evaluateType(header)
        match  {
            case types == TarConstants.FORMAT_OLDGNU => 
                offset += TarConstants.ATIMELEN_GNU
                offset += TarConstants.CTIMELEN_GNU
                offset += TarConstants.OFFSETLEN_GNU
                offset += TarConstants.LONGNAMESLEN_GNU
                offset += TarConstants.PAD2LEN_GNU
                this.sparseHeaders = TarUtils.readSparseStructs(header, offset, TarConstants.SPARSE_HEADERS_IN_OLDGNU_HEADER)
                offset += TarConstants.SPARSELEN_GNU
                this.isExtended = TarUtils.parseBoolean(header, offset)
                offset += TarConstants.ISEXTENDEDLEN_GNU
                this.realSize = TarUtils.parseOctal(header, offset, TarConstants.REALSIZELEN_GNU)
                offset += TarConstants.REALSIZELEN_GNU
            case types == TarConstants.FORMAT_XSTAR =>
                let xstarPrefix: String = if (oldStyle) {
                    TarUtils.parseName(header, offset, TarConstants.PREFIXLEN_XSTAR)
                } else {
                    TarUtils.parseNameEncoding(header, offset, TarConstants.PREFIXLEN_XSTAR, encoding)
                }
                if (xstarPrefix.size > 0) {
                    this.name = xstarPrefix + "/" + this.name
                }
            case _ =>
                let prefix: String = if (oldStyle) {
                    TarUtils.parseName(header, offset, TarConstants.PREFIXLEN)
                } else {
                    TarUtils.parseNameEncoding(header, offset, TarConstants.PREFIXLEN, encoding)
                }
                if (this.isDirectory() && !this.name.endsWith("/")) {
                    this.name = this.name + "/"
                }
                if (prefix.size > 0) {
                    this.name = prefix + "/" + this.name
                }
        }
    }