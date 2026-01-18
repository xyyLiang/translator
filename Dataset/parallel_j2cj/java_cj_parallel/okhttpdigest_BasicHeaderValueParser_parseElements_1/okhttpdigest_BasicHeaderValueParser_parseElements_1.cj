    public func parseElements(buffer: CharArrayBuffer, cursor: ParserCursor): ArrayList<BasicHeaderElement> {

        var elements: ArrayList<BasicHeaderElement> = ArrayList<BasicHeaderElement>()

        while(true) {
            var element: BasicHeaderElement = BasicHeaderElement("", "", ArrayList<BasicNameValuePair>())

            do {
                if(cursor.atEnd()) {
                    return elements
                }
                element = this.parseHeaderElement(buffer, cursor)
            } while(element.getName().size == 0 && element.getValue().isEmpty())

            elements.append(element)

        }
        return elements
    }