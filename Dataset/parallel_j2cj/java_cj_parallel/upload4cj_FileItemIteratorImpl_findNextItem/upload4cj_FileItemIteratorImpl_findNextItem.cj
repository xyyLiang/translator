    private func findNextItem(): Bool {
        if (eof) {
            return false
        }
        doResetCurrentItem()
        while (true) {
            var nextPart: Bool = calcNextPart()
            if (!nextPart) {
                if (let Some(_) <- currentFieldName) {}
                else {
                    eof = true
                    return false
                }
                multi.getOrThrow().setBoundary(boundary.getOrThrow())
                currentFieldName = Option<String>.None
                continue
            }
            let headers: FileItemHeaders = mfileuploadBase.getOrThrow().getParsedHeaders(multi.getOrThrow().readHeaders())
            if (let Some(j) <- currentFieldName) {
                let fileName: Option<String> = mfileuploadBase.getOrThrow().getFileName(headers)
                if (let Some(n) <- fileName) {
                    currentItem = FileItemStreamImpl(n,j,headers.getHeader(CONTENT_TYPE),false,getContentLength(headers),mfileuploadBase,this)
                    currentItem.getOrThrow().setHeaders(headers)
                    notifier.getOrThrow().noteItem()
                    itemValid = true
                    return true
                }
            } else {
                let fieldName: Option<String> = mfileuploadBase.getOrThrow().getFieldName(headers)
                if (let Some(k) <- fieldName) {
                    let subContentType: Option<String> = headers.getHeader(CONTENT_TYPE)
                    if (let Some(l) <- subContentType) {
                        let nameLower: String = l.toAsciiLower()
                        if (nameLower.startsWith(MULTIPART_MIXED)) {
                            currentFieldName = fieldName
                            // Multiple files associated with this field name
                            let subBoundary: Array<UInt8> = getBoundary(l).getOrThrow()
                            multi.getOrThrow().setBoundary(subBoundary)
                            skipPreamble = true
                            continue
                        }
                    }
                    doLogic(headers,k)
                    return true
                }
            }
            multi.getOrThrow().discardBodyData()
        }
        return false
    }
