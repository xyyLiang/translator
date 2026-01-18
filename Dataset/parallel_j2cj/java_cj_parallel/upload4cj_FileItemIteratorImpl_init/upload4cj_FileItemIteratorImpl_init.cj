    init(ctx: Option<RequestContext>, fileupLoadBase: FileUploadBase) {
        this.mfileuploadBase = fileupLoadBase
        if (let Some(i) <- ctx) {
            let contentType: Option<String> = i.getContentType()
            if (let Some(j) <- contentType) {
                if (!j.toAsciiLower().startsWith(MULTIPART)) {
                    throw InvalidContentTypeException("the request doesn't contain a " + MULTIPART_FORM_DATA + " or " + MULTIPART_MIXED +" stream, content type header is " + j)
                } else {
                    //正常逻辑
                    let contentLengthInt: Int64 = i.contentLength()
                    //这个先遗留
                    let requestSize: Int64 = contentLengthInt
                    var input: Option<InputStream> = Option<InputStream>.None
                    if (this.mfileuploadBase.getOrThrow().sizeMax >= 0) {
                        //表示request内容长度有限制
                        if (requestSize != -1 && requestSize > this.mfileuploadBase.getOrThrow().sizeMax) {
                            throw SizeLimitExceededException("the request was rejected because its size (" + requestSize.toString() +") exceeds the configured maximum (" +this.mfileuploadBase.getOrThrow().sizeMax.toString() + ")")
                        }
                        // N.B. this is eventually closed in MultipartStream processing
                        input = LimitedInputStreamImpl(ctx.getOrThrow().getInputStream(),this.mfileuploadBase.getOrThrow().sizeMax,Option<ItemInputStream>.None)
                    } else {
                        input = i.getInputStream()
                    }
                    var charEncoding: Option<String> = headerEncoding
                    if (let Some(_) <- charEncoding) {}
                    else {
                        charEncoding = i.getCharacterEncoding()
                    }
                    boundary = getBoundary(j)
                    if (let Some(_) <- boundary) {
                        notifier = ProgressNotifier(mfileuploadBase.getOrThrow().getProgressListener(), requestSize)
                        try {
                            multi = MultipartStream(input.getOrThrow(), boundary, notifier.getOrThrow())
                        } catch (iae: IllegalArgumentException) {
                            throw InvalidContentTypeException("The boundary specified in the " + CONTENT_TYPE + " header is too long" + iae.toString())
                        }
                        multi.getOrThrow().setHeaderEncoding(charEncoding)
                        skipPreamble = true
                        findNextItem()
                    } else {
                        throw FileUploadException("the request was rejected because no multipart boundary was found")
                    }
                }
            } else {
                throw InvalidContentTypeException("the request doesn't contain a " + MULTIPART_FORM_DATA + " or " + MULTIPART_MIXED +" stream, content type header is null")
            }
        } else {
            throw NullPointerException("ctx parameter")
        }
    }