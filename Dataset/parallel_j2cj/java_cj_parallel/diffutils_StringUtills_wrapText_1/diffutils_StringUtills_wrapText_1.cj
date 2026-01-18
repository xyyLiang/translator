    public static func wrapText(line: String, columnWidth: Int64): String {
        var res = line
        var lenght: Int64 = line.size
        var delimiter: Int64 = "<br>".size
        var widthIndex: Int64 = columnWidth
        var count: Int64 = 0
        while (lenght > widthIndex ) {
            res = res[0..widthIndex + delimiter * count] + "<br>" + res[widthIndex + delimiter * count..]
            widthIndex += columnWidth
            count++
        }
        return res
    }