    @Nullable private static String parseContentDisposition(String contentDisposition)
            throws IOException {
        if (contentDisposition == null) {
            return null;
        }

        try {
            String fileName = null;
            Matcher m = CONTENT_DISPOSITION_QUOTED_PATTERN.matcher(contentDisposition);
            if (m.find()) {
                fileName = m.group(1);
            } else  {
                m = CONTENT_DISPOSITION_NON_QUOTED_PATTERN.matcher(contentDisposition);
                if (m.find()) {
                    fileName = m.group(1);
                }
            }

            if (fileName != null && fileName.contains("../")) {
                throw new DownloadSecurityException("The filename [" + fileName + "] from"
                    + " the response is not allowable, because it contains '../', which "
                    + "can raise the directory traversal vulnerability");
            }

            return fileName;
        } catch (IllegalStateException ex) {
            // This function is defined as returning null when it can't parse the header
        }
        return null;
    }