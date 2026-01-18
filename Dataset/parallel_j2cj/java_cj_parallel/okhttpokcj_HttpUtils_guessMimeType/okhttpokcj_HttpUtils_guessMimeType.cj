    public static func guessMimeType(fileName: String): String {

        var temp = fileName.replace("#", "")

        if (temp.isEmpty()) {
            return HttpParams.MEDIA_TYPE_STREAM
        }

        return temp
    }