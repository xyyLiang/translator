    public static String checkFileName(String fileName) {
        if (fileName != null  &&  fileName.indexOf('\u0000') != -1) {
            // pFileName.replace("\u0000", "\\0")
            final StringBuilder sb = new StringBuilder();
            for (int i = 0;  i < fileName.length();  i++) {
                char c = fileName.charAt(i);
                switch (c) {
                    case 0:
                        sb.append("\\0");
                        break;
                    default:
                        sb.append(c);
                        break;
                }
            }
            throw new InvalidFileNameException(fileName,
                    "Invalid file name: " + sb);
        }
        return fileName;
    }