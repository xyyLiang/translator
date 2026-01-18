    synchronized DownloadOutputStream outputStream(int blockIndex) throws IOException {
        DownloadOutputStream outputStream = outputStreamMap.get(blockIndex);

        if (outputStream == null) {
            @NonNull final Uri uri;
            final boolean isFileScheme = Util.isUriFileScheme(task.getUri());
            if (isFileScheme) {
                final File file = task.getFile();
                if (file == null) throw new FileNotFoundException("Filename is not ready!");

                final File parentFile = task.getParentFile();
                if (!parentFile.exists() && !parentFile.mkdirs()) {
                    throw new IOException("Create parent folder failed!");
                }

                if (file.createNewFile()) {
                    Util.d(TAG, "Create new file: " + file.getName());
                }

                uri = Uri.fromFile(file);
            } else {
                uri = task.getUri();
            }

            outputStream = OkDownload.with().outputStreamFactory().create(
                    OkDownload.with().context(),
                    uri,
                    flushBufferSize);
            if (supportSeek) {
                final long seekPoint = info.getBlock(blockIndex).getRangeLeft();
                if (seekPoint > 0) {
                    // seek to target point
                    outputStream.seek(seekPoint);
                    Util.d(TAG, "Create output stream write from (" + task.getId()
                            + ") block(" + blockIndex + ") " + seekPoint);
                }
            }

            if (firstOutputStream) {
                store.markFileDirty(task.getId());
            }

            if (!info.isChunked() && firstOutputStream && isPreAllocateLength) {
                // pre allocate length
                final long totalLength = info.getTotalLength();
                if (isFileScheme) {
                    final File file = task.getFile();
                    final long requireSpace = totalLength - file.length();
                    if (requireSpace > 0) {
                        inspectFreeSpace(new StatFs(file.getAbsolutePath()), requireSpace);
                        outputStream.setLength(totalLength);
                    }
                } else {
                    outputStream.setLength(totalLength);
                }
            }

            synchronized (noSyncLengthMap) {
                // make sure the length of noSyncLengthMap is equal to outputStreamMap
                outputStreamMap.put(blockIndex, outputStream);
                noSyncLengthMap.put(blockIndex, new AtomicLong());
            }

            firstOutputStream = false;
        }

        return outputStream;
    }
