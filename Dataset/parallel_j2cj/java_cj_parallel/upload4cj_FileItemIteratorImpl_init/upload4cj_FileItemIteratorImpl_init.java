        FileItemIteratorImpl(RequestContext ctx)
                throws FileUploadException, IOException {
            if (ctx == null) {
                throw new NullPointerException("ctx parameter");
            }

            String contentType = ctx.getContentType();
            if ((null == contentType)
                    || (!contentType.toLowerCase(Locale.ENGLISH).startsWith(MULTIPART))) {
                throw new InvalidContentTypeException(
                        format("the request doesn't contain a %s or %s stream, content type header is %s",
                               MULTIPART_FORM_DATA, MULTIPART_MIXED, contentType));
            }


            @SuppressWarnings("deprecation") // still has to be backward compatible
            final int contentLengthInt = ctx.getContentLength();

            final long requestSize = UploadContext.class.isAssignableFrom(ctx.getClass())
                                     // Inline conditional is OK here CHECKSTYLE:OFF
                                     ? ((UploadContext) ctx).contentLength()
                                     : contentLengthInt;
                                     // CHECKSTYLE:ON

            InputStream input; // N.B. this is eventually closed in MultipartStream processing
            if (sizeMax >= 0) {
                if (requestSize != -1 && requestSize > sizeMax) {
                    throw new SizeLimitExceededException(
                        format("the request was rejected because its size (%s) exceeds the configured maximum (%s)",
                                Long.valueOf(requestSize), Long.valueOf(sizeMax)),
                               requestSize, sizeMax);
                }
                // N.B. this is eventually closed in MultipartStream processing
                input = new LimitedInputStream(ctx.getInputStream(), sizeMax) {
                    @Override
                    protected void raiseError(long pSizeMax, long pCount)
                            throws IOException {
                        FileUploadException ex = new SizeLimitExceededException(
                        format("the request was rejected because its size (%s) exceeds the configured maximum (%s)",
                                Long.valueOf(pCount), Long.valueOf(pSizeMax)),
                               pCount, pSizeMax);
                        throw new FileUploadIOException(ex);
                    }
                };
            } else {
                input = ctx.getInputStream();
            }

            String charEncoding = headerEncoding;
            if (charEncoding == null) {
                charEncoding = ctx.getCharacterEncoding();
            }

            boundary = getBoundary(contentType);
            if (boundary == null) {
                IOUtils.closeQuietly(input); // avoid possible resource leak
                throw new FileUploadException("the request was rejected because no multipart boundary was found");
            }

            notifier = new MultipartStream.ProgressNotifier(listener, requestSize);
            try {
                multi = new MultipartStream(input, boundary, notifier);
            } catch (IllegalArgumentException iae) {
                IOUtils.closeQuietly(input); // avoid possible resource leak
                throw new InvalidContentTypeException(
                        format("The boundary specified in the %s header is too long", CONTENT_TYPE), iae);
            }
            multi.setHeaderEncoding(charEncoding);

            skipPreamble = true;
            findNextItem();
        }
