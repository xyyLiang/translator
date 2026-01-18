    private static func processDeltas(origLines: ArrayList<String>,
             deltas: ArrayList<Delta<String>>, contextSize: Int64): ArrayList<String> {
        var buffer =  ArrayList<String>()
        var origTotal: Int64 = 0 // counter for total lines output from Original
        var revTotal: Int64 = 0 // counter for total lines output from Original

        var curDelta: Delta<String> = deltas.get(0).getOrThrow()

        // NOTE: +1 to overcome the 0-offset Position
        var origStart = curDelta.getOriginal().getPosition() + 1 - contextSize

        var revStart = curDelta.getRevised().getPosition() + 1 - contextSize

        // find the start of the wrapper context code
        var contextStart = curDelta.getOriginal().getPosition() - contextSize
        (origStart,revStart,contextStart) = checkVal(origStart,revStart,contextStart)
        // output the context before the first Delta
        var line: Int64 = contextStart
        while (line < curDelta.getOriginal().getPosition()) { //
            buffer.append(" " + origLines.get(line).getOrThrow())
            origTotal++
            revTotal++
            line++
        }

        // output the first Delta
        buffer.appendAll(getDeltaText(curDelta))
        origTotal += curDelta.getOriginal().getLines().size
        revTotal += curDelta.getRevised().getLines().size

        var deltaIndex = 1
        while (deltaIndex < deltas.size) { // for each of the other Deltas
            var nextDelta: Delta<String> = deltas.get(deltaIndex).getOrThrow()
            var intermediateStart = curDelta.getOriginal().getPosition()+ curDelta.getOriginal().getLines().size
            line = intermediateStart
            while ( line < nextDelta.getOriginal().getPosition() ) {
                // output the code between the last Delta and this one
                buffer.append(" " + origLines.get(line).getOrThrow())
                origTotal++
                revTotal++
                line++
            }
            buffer.appendAll(getDeltaText(nextDelta)) // output the Delta
            origTotal += nextDelta.getOriginal().getLines().size
            revTotal += nextDelta.getRevised().getLines().size
            curDelta = nextDelta
            deltaIndex++
        }

        // Now output the post-Delta context code, clamping the end of the file
        contextStart = curDelta.getOriginal().getPosition()    + curDelta.getOriginal().getLines().size
        line = contextStart
        while ( (line < (contextStart + contextSize))&& (line < origLines.size)) {
            buffer.append(" " + origLines.get(line).getOrThrow())
            origTotal++
            revTotal++
            line++
        }

        // Create and insert the block header, conforming to the Unified Diff
        // standard
        var header = appendHeader(origStart,origTotal,revStart,revTotal)
        buffer.insert(0, header.toString())
        return buffer
    }