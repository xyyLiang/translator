    private static List<String> processDeltas(List<String> origLines,
            List<AbstractDelta<String>> deltas, int contextSize, boolean newFile) {
        List<String> buffer = new ArrayList<>();
        int origTotal = 0; // counter for total lines output from Original
        int revTotal = 0; // counter for total lines output from Original
        int line;

        AbstractDelta<String> curDelta = deltas.get(0);
        int origStart;
        if (newFile) {
            origStart = 0;
        } else {
            // NOTE: +1 to overcome the 0-offset Position
            origStart = curDelta.getSource().getPosition() + 1 - contextSize;
            if (origStart < 1) {
                origStart = 1;
            }
        }

        int revStart = curDelta.getTarget().getPosition() + 1 - contextSize;
        if (revStart < 1) {
            revStart = 1;
        }

        // find the start of the wrapper context code
        int contextStart = curDelta.getSource().getPosition() - contextSize;
        if (contextStart < 0) {
            contextStart = 0; // clamp to the start of the file
        }

        // output the context before the first Delta
        for (line = contextStart; line < curDelta.getSource().getPosition(); line++) { //
            buffer.add(" " + origLines.get(line));
            origTotal++;
            revTotal++;
        }

        // output the first Delta
        buffer.addAll(getDeltaText(curDelta));
        origTotal += curDelta.getSource().getLines().size();
        revTotal += curDelta.getTarget().getLines().size();

        int deltaIndex = 1;
        while (deltaIndex < deltas.size()) { // for each of the other Deltas
            AbstractDelta<String> nextDelta = deltas.get(deltaIndex);
            int intermediateStart = curDelta.getSource().getPosition()
                    + curDelta.getSource().getLines().size();
            for (line = intermediateStart; line < nextDelta.getSource()
                    .getPosition(); line++) {
                // output the code between the last Delta and this one
                buffer.add(" " + origLines.get(line));
                origTotal++;
                revTotal++;
            }
            buffer.addAll(getDeltaText(nextDelta)); // output the Delta
            origTotal += nextDelta.getSource().getLines().size();
            revTotal += nextDelta.getTarget().getLines().size();
            curDelta = nextDelta;
            deltaIndex++;
        }

        // Now output the post-Delta context code, clamping the end of the file
        contextStart = curDelta.getSource().getPosition()
                + curDelta.getSource().getLines().size();
        for (line = contextStart; (line < (contextStart + contextSize))
                && (line < origLines.size()); line++) {
            buffer.add(" " + origLines.get(line));
            origTotal++;
            revTotal++;
        }

        // Create and insert the block header, conforming to the Unified Diff
        // standard
        StringBuilder header = new StringBuilder();
        header.append("@@ -");
        header.append(origStart);
        header.append(",");
        header.append(origTotal);
        header.append(" +");
        header.append(revStart);
        header.append(",");
        header.append(revTotal);
        header.append(" @@");
        buffer.add(0, header.toString());

        return buffer;
    }
