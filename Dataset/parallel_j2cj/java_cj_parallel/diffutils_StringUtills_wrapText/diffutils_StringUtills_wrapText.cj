    public static func wrapText( list: ArrayList<String>, columnWidth: Int64): ArrayList<String> {
        var result: ArrayList<String> =  ArrayList<String>()
        for (line in list) {
            result.append(wrapText(line, columnWidth));
        }
        return result;
    }