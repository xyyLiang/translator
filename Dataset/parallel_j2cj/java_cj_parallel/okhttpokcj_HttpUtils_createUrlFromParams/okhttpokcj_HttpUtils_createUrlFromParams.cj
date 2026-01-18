    public static func createUrlFromParams(url: String, params: LinkedHashMap<String, ArrayList<String>>): String {
        try {
            let sb: StringBuilder = StringBuilder()
            sb.append(url)
            if (url.contains('&') || url.contains('?')) {
                sb.append("&")
            } else {
                sb.append("?")
            }
            for ((k,v) in params) {
                sb.append(k).append("=").append(v).append("&")
            }
            sb.remove(sb.size - 1)
            return sb.toString()
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return url
    }