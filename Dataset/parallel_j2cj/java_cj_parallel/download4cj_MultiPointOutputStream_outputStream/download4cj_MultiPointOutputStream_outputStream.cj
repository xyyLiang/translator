    func outputStream(blockIndex:Int64):DownloadOutputStream{
        synchronized(m){
            var outputStream:Option<DownloadOutputStream> = outputStreamMap.get(blockIndex)
            if(let Some(_) <- outputStream){
            }else{
                var uri:String
                let isFileScheme:Bool = Util.isUriFileScheme(task.getUri())
                if(!isFileScheme){
                    let file:Option<File> = task.getFile()
                    if(let Some(_) <- file){
                    }else{
                        throw FileNotFoundException("Filename is not ready!")
                    }

                    let parentFile:Directory = task.getParentFile()
                    if(!Directory.exists(parentFile.info.path)){
                        try{
                            Directory.create(parentFile.info.path)
                        }catch(e:ReadWriteException){
                            throw ReadWriteException("Create parent folder failed!")
                        }
                    }
                    try{
                        parentFile.createFile(file.getOrThrow().info.path.fileName.getOrThrow())
                        Util.d(TAG, "Create new file: " + file.getOrThrow().info.path.fileName.getOrThrow())
                    }catch(e:Exception){
                    }
                    uri = file.getOrThrow().info.path.toString()
                }else{
                    uri = task.getUri()
                }
                outputStream = Download4cj.withs().outputStreamFactory().create(uri,flushBufferSize)
                if(supportSeek){
                    let seekPoint:Int64 = info.getBlock(blockIndex).getOrThrow().getRangeLeft()
                    if (seekPoint > 0){
                        // seek to target point
                        outputStream.getOrThrow().seek(seekPoint)
                        Util.d(TAG, "Create output stream write from (" + task.getId().toString()+ ") block(" + blockIndex.toString() + ") " + seekPoint.toString())
                    }
                }

                if (firstOutputStream) {
                    store.markFileDirty(task.getId())
                }
                if (!info.isChunked() && firstOutputStream && isPreAllocateLength) {
                    // pre allocate length
                    let totalLength:Int64 = info.getTotalLength()
                    if (!isFileScheme) {
                        let file:Option<File> = task.getFile()
                        let requireSpace:Int64 = totalLength - file.getOrThrow().info.length
                        if (requireSpace > 0) {
                            outputStream.getOrThrow().setLength(totalLength)
                        }
                    } else {
                        outputStream.getOrThrow().setLength(totalLength)
                    }
                }
                synchronized (m2) {
                    // make sure the length of noSyncLengthMap is equal to outputStreamMap
                    outputStreamMap.put(blockIndex, outputStream.getOrThrow())
                    noSyncLengthMap.put(blockIndex, AtomicInt64(0))
                }
                firstOutputStream = false
            }
            return outputStream.getOrThrow()
        }
    }