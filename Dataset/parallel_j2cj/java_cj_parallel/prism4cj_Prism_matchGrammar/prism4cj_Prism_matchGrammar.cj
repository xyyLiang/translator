    private func matchGrammar(
        text: String,
        entries: ArrayList<Node>,
        grammar: Grammar,
        index: Int64,
        startPosition: Int64,
        oneShot: Bool,
        target: ?Token
    ): Unit {
        let textLength: Int64 = text.size
        for (token in grammar.tokens()) {
            if (let Some(v) <- target) {
                if (token == v) {
                    return
                }
            }
            for (pattern in token.patterns()) {
                let lookbehind: Bool = pattern.lookbehind()
                let greedy: Bool = pattern.greedy()
                var lookbehindLength: Int64 = 0
                let regex: Regex = pattern.regex()
                // Don't cache textLength as it changes during the loop
                var i: Int64 = index
                var position: Int64 = startPosition
                while (i < entries.size) {
                    if (entries.size > textLength) {
                        throw Exception(
                            "prism internal error. Number of entry nodes " + "is greater that the text length.\n" +
                            "Nodes: " + entries.toString() + "\n" + "Text: " + text)
                    }
                    let node: ?Node = entries.get(i)
                    if (node.isSome() && isSyntaxNode(node.getOrThrow())) {
                        continue
                    }
                    var str: String = ""
                    if (node.isSome()) {
                        str = (node.getOrThrow() as Text).getOrThrow().literal()
                    }
                    var matcher: Matcher
                    var deleteCount: Int64
                    var greedyMatch: Bool
                    var greedyAdd: Int64 = 0
                    if (greedy && i != entries.size - 1) {
                        matcher = regex.matcher(text)
                        // limit search to the position (?)
                        matcher.setRegion(position, textLength)
                        let matchData1: ?MatchData = matcher.find()
                        if (matchData1.isNone()) {
                            break
                        }
                        let matchRealData1: MatchData = matchData1.getOrThrow()
                        var begin: Int64 = matchRealData1.matchPosition().start
                        if (lookbehind) {
                            begin += matchRealData1.matchStr(1).size
                        }
                        let to: Int64 = matchRealData1.matchPosition().start + matchRealData1.matchStr(0).size
                        var k = i
                        var p = position
                        let len: Int64 = entries.size
                        while (k < len && (p < to || (!isSyntaxNode(entries.get(k).getOrThrow()) &&
                                !isGreedyNode(entries.get(k - 1).getOrThrow())))) {
                            match (entries.get(k)) {
                                case Some(v) => p += v.textLength()
                                case None => ()
                            }
                            // Move the index i to the element in strarr that is closest to from
                            if (begin >= p) {
                                i += 1
                                position = p
                            }
                            k++
                        }
                        if (entries.get(i).isSome() && isSyntaxNode(entries[i])) {
                            continue
                        }
                        deleteCount = k - i
                        str = text[position..p]
                        greedyMatch = true
                        greedyAdd = -position
                    } else {
                        matcher = regex.matcher(str)
                        deleteCount = 1
                        greedyMatch = false
                    }
                    let matchData2: ?MatchData = matcher.find()
                    if (!greedyMatch && matchData2.isNone()) {
                        if (oneShot) {
                            break
                        }
                        continue
                    }
                    let matchRealData2: MatchData = matchData2.getOrThrow()
                    if (lookbehind) {
                        let group: String = matchRealData2.matchStr(1)
                        lookbehindLength = group.size
                    }
                    let begin02: Int64 = matchRealData2.matchPosition().start + greedyAdd + lookbehindLength
                    var mat: String
                    if (lookbehindLength > 0) {
                        mat = matchRealData2.matchStr()[lookbehindLength..]
                    } else {
                        mat = matchRealData2.matchStr()
                    }
                    var to02: Int64 = begin02 + mat.size
                    for (_ in 0..deleteCount) {
                        entries.remove(i)
                    }
                    var i2: Int64 = i
                    if (begin02 != 0) {
                        let before: String = str[..begin02]
                        i += 1
                        position += before.size
                        entries.insert(i2, TextImpl(before))
                        i2++
                    }
                    var tokenEntries: ArrayList<Node>
                    let inside: ?Grammar = pattern.inside()
                    var hasInside: Bool = if (inside.isSome()) {
                        true
                    } else {
                        false
                    }
                    if (hasInside) {
                        tokenEntries = tokenize(mat, inside.getOrThrow())
                    } else {
                        tokenEntries = ArrayList<Node>(TextImpl(mat))
                    }
                    let syntaxImp: Syntax = SyntaxImpl(token.name(), tokenEntries, pattern.alias(), mat, greedy,
                        hasInside)
                    entries.insert(i2, syntaxImp)
                    i2++
                    // important thing here (famous off-by one error) to check against full length (not `length - 1`)
                    if (to02 < str.size) {
                        let after: String = str[to02..]
                        entries.insert(i2, TextImpl(after))
                    }
                    if (deleteCount != 1) {
                        matchGrammar(text, entries, grammar, i, position, true, token)
                    }
                    if (oneShot) {
                        break
                    }
                    match (entries.get(i)) {
                        case Some(v) => position += v.textLength()
                        case None => ()
                    }
                    i++
                }
            }
        }
    }