    public func escape(input: String): StringEscapeBuilder {
        sb.append(translator.translate(input));
        return this
    }