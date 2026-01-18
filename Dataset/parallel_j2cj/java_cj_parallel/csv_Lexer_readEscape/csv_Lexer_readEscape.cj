    func readEscape(): Option<Rune> {
        let ch = reader.read();
        if (reader.getIsEndOfStream()) {
            Option<Rune>.None
        }

        let chr = ch ?? Constants.DISABLED
        match (chr) {
            case 'r' => return Constants.CR;
            case 'n' => return Constants.LF;
            case 't' => return Constants.TAB;
            case 'b' => return Constants.BACKSPACE;
            case 'f' => return Constants.FF;
            case _ => return chr
        }
    }