    static func addEdges(input: Input, edges: Array<Array<?Edge>>, `from`: Int64, previous: ?Edge) {
        if (input.isECI(`from`)) {
            addEdge(edges, Edge(input, ASCII, `from`, 1, previous))
            return
        }

        let ch = input.charAt(`from`)

        if (if (let Some(pre) = previous) {
            pre.getEndMode() != EDF
        } else {
            true
        }) {
            if (HighLevelEncoder.isDigit(ch) && input.haveNCharacters(`from`, 2) && HighLevelEncoder.isDigit(
                input.charAt(`from` + 1))) {
                addEdge(edges, Edge(input, ASCII, `from`, 2, previous))
            } else {
                addEdge(edges, Edge(input, ASCII, `from`, 1, previous))
            }

            let modes = [C40, TEXT]
            for (mode in modes) {
                let characterLength = [0]
                if (getNumberOfC40Words(input, `from`, mode == C40, characterLength) > 0) {
                    addEdge(edges, Edge(input, mode, `from`, characterLength[0], previous))
                }
            }

            if (input.haveNCharacters(`from`, 3) && HighLevelEncoder.isNativeX12(input.charAt(`from`)) &&
                HighLevelEncoder.isNativeX12(input.charAt(`from` + 1)) && HighLevelEncoder.isNativeX12(
                input.charAt(`from` + 2))) {
                addEdge(edges, Edge(input, X12, `from`, 3, previous))
            }

            addEdge(edges, Edge(input, B256, `from`, 1, previous))
        }

        var i = 0
        while (i < 3) {
            let pos = `from` + i
            if (input.haveNCharacters(pos, 1) && HighLevelEncoder.isNativeEDIFACT(input.charAt(pos))) {
                addEdge(edges, Edge(input, EDF, `from`, i + 1, previous))
            } else {
                break
            }
            i++
        }
        if (i == 3 && input.haveNCharacters(`from`, 4) && HighLevelEncoder.isNativeEDIFACT(input.charAt(`from` + 3))) {
            addEdge(edges, Edge(input, EDF, `from`, 4, previous))
        }
    }