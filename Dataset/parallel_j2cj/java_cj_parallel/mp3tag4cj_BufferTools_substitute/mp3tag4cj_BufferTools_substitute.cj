    @OverflowWrapping
    public static func substitute(s: String, replaceThis: String, withThis: Option<String>): String {
        if (replaceThis.size < 1 || !s.contains(replaceThis)) {
            return s
        }
        var newString: StringBuilder = StringBuilder()
        var lastPosition: Int64 = 0;
        var position: Int64 = 0;
        position = match (s.indexOf(replaceThis, position)) {
            case Some(x) => x
            case None => -1
        }
        while (position >= 0) {
            if (position > lastPosition) {
                var subStr = s[lastPosition..position]
                newString.append(subStr)
            }
            match (withThis) {
                case Some(x) => newString.append(x)
                case None => ()
            }
            lastPosition = position + replaceThis.size
            position++
            position = match (s.indexOf(replaceThis, position)) {
                case Some(x) => x
                case None => -1
            }
        }
        if (lastPosition < s.size) {
            newString.append(s[lastPosition..])
        }
        return newString.toString()
    }