    public HeaderElement[] parseElements(CharArrayBuffer buffer, ParserCursor cursor) {
        Args.notNull(buffer, "Char array buffer");
        Args.notNull(cursor, "Parser cursor");
        ArrayList elements = new ArrayList();

        while(true) {
            HeaderElement element;
            do {
                if(cursor.atEnd()) {
                    return (HeaderElement[])elements.toArray(new HeaderElement[elements.size()]);
                }

                element = this.parseHeaderElement(buffer, cursor);
            } while(element.getName().length() == 0 && element.getValue() == null);

            elements.add(element);
        }
    }