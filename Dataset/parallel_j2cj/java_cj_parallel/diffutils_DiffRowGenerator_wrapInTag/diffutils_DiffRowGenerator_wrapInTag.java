    static void wrapInTag(List<String> sequence, int startPosition,
            int endPosition, Tag tag, BiFunction<Tag, Boolean, String> tagGenerator,
            Function<String, String> processDiffs, boolean replaceLinefeedWithSpace) {
        int endPos = endPosition;

        while (endPos >= startPosition) {

            //search position for end tag
            while (endPos > startPosition) {
                if (!"\n".equals(sequence.get(endPos - 1))) {
                    break;
                } else if (replaceLinefeedWithSpace) {
                    sequence.set(endPos - 1, " ");
                    break;
                }
                endPos--;
            }

            if (endPos == startPosition) {
                break;
            }

            sequence.add(endPos, tagGenerator.apply(tag, false));
            if (processDiffs != null) {
                sequence.set(endPos - 1,
                        processDiffs.apply(sequence.get(endPos - 1)));
            }
            endPos--;

            //search position for end tag
            while (endPos > startPosition) {
                if ("\n".equals(sequence.get(endPos - 1))) {
                    if (replaceLinefeedWithSpace) {
                        sequence.set(endPos - 1, " ");
                    } else {
                        break;
                    }
                }
                if (processDiffs != null) {
                    sequence.set(endPos - 1,
                            processDiffs.apply(sequence.get(endPos - 1)));
                }
                endPos--;
            }

            sequence.add(endPos, tagGenerator.apply(tag, true));
            endPos--;
        }
    }
