public static List<String> generateUnifiedDiff(String originalFileName,
            String revisedFileName, List<String> originalLines, Patch<String> patch,
            int contextSize) {
        if (!patch.getDeltas().isEmpty()) {
            List<String> ret = new ArrayList<>();
            ret.add("--- " + Optional.ofNullable(originalFileName).orElse(NULL_FILE_INDICATOR));
            ret.add("+++ " + Optional.ofNullable(revisedFileName).orElse(NULL_FILE_INDICATOR));

            List<AbstractDelta<String>> patchDeltas = new ArrayList<>(
                    patch.getDeltas());

            // code outside the if block also works for single-delta issues.
            List<AbstractDelta<String>> deltas = new ArrayList<>(); // current
            // list
            // of
            // Delta's to
            // process
            AbstractDelta<String> delta = patchDeltas.get(0);
            deltas.add(delta); // add the first Delta to the current set
            // if there's more than 1 Delta, we may need to output them together
            if (patchDeltas.size() > 1) {
                for (int i = 1; i < patchDeltas.size(); i++) {
                    int position = delta.getSource().getPosition(); // store
                    // the
                    // current
                    // position
                    // of
                    // the first Delta

                    // Check if the next Delta is too close to the current
                    // position.
                    // And if it is, add it to the current set
                    AbstractDelta<String> nextDelta = patchDeltas.get(i);
                    if ((position + delta.getSource().size() + contextSize) >= (nextDelta
                            .getSource().getPosition() - contextSize)) {
                        deltas.add(nextDelta);
                    } else {
                        // if it isn't, output the current set,
                        // then create a new set and add the current Delta to
                        // it.
                        List<String> curBlock = processDeltas(originalLines,
                                deltas, contextSize, false);
                        ret.addAll(curBlock);
                        deltas.clear();
                        deltas.add(nextDelta);
                    }
                    delta = nextDelta;
                }

            }
            // don't forget to process the last set of Deltas
            List<String> curBlock = processDeltas(originalLines, deltas,
                    contextSize, patchDeltas.size() == 1 && originalFileName == null);
            ret.addAll(curBlock);
            return ret;
        }
        return new ArrayList<>();
    }