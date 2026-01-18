    public static func wrapInTag(line: String, tag: String, cssClass: ?String): String {
        var tagBuilder = StringBuilder()
        tagBuilder.append("<")
        tagBuilder.append(tag)
        if (let Some(v) <- cssClass) {
            tagBuilder.append(" class=\"")
            tagBuilder.append(v)
            tagBuilder.append("\"")
        }
        tagBuilder.append(">")
        var startTag = tagBuilder.toString()

        tagBuilder.reset()

        tagBuilder.append("</")
        tagBuilder.append(tag)
        tagBuilder.append(">")
        var endTag = tagBuilder.toString()

        return startTag + line + endTag
    }