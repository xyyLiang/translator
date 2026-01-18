    public func parseRequest(ctx: RequestContext): Option<ArrayList<FileItem>> {
        let items: ArrayList<FileItem> = ArrayList<FileItem>()
        var successful: Bool = false
        try {
            let iter: FileItemIterator = getItemIterator(ctx)
            let fac: Option<FileItemFactory> = getFileItemFactory()
            let buffer: Array<UInt8> = Array<UInt8>(Streams.DEFAULT_BUFFER_SIZE, item: 0)
            if (let Some(_) <- fac) {}
            else {
                throw NullPointerException("No FileItemFactory has been set.")
            }
            while (iter.hasNext()) {
                if (items.size == fileCountMax) {
                    throw FileCountLimitExceededException(ATTACHMENT, getFileCountMax())
                }
                let item: FileItemStream = iter.next()
                let asItem = item as FileItemStreamImpl
                var fileName: Option<String> = Option<String>.None
                if (let Some(j) <- asItem) {
                    fileName = j.name
                    if (let Some(k) <- fileName) {
                        fileName = k
                    } else {
                        fileName = ""
                    }
                }
                let fileItem: FileItem = fac.getOrThrow().createItem(item.getFieldName(),item.getContentType(),item.isFormField(),fileName.getOrThrow())
                items.append(fileItem)
                try {
                    Streams.copy(item.openStream(), fileItem.getOutputStream(), true, buffer)
                    let outputStream = fileItem.getOutputStream()
                    let deferr = outputStream as DeferredFileOutputStream
                    if(let Some(m) <- deferr){
                        m.close()
                    }
                } catch (e: FileUploadException) {
                    throw FileUploadException("ParseRequest Fail")
                } catch (e: ReadWriteException) {
                    throw ReadWriteException("Processing of " + MULTIPART_FORM_DATA + " request failed.")
                }
                let fih: FileItemHeaders = item.getHeaders()
                fileItem.setHeaders(fih)
            }
            successful = true
            return items
        } catch (e: FileUploadException) {
            throw FileUploadException("ParseRequest Fail!")
        } catch (e: ReadWriteException) {
            throw ReadWriteException("read write exception")
        } finally {
            doFinally(successful,items)
        }
    }