public static func generateUnifiedDiff(original: String,
            revised: String, originalLines: ArrayList<String>, patch: Patch<String>,
            contextSize: Int64): ArrayList<String> {
        if (!patch.getDeltas().isEmpty()) {
            var ret = ArrayList<String>()
            ret.append("--- " + original)
            ret.append("+++ " + revised)

            var patchDeltas: ArrayList<Delta<String>> = ArrayList<Delta<String>>(
                    patch.getDeltas())

            // code outside the if block also works for single-delta issues.
            var deltas: ArrayList<Delta<String>> = ArrayList<Delta<String>>() 
            // current
            // list
            // of
            // Delta's to
            // process
            var delta: Delta<String> = patchDeltas.get(0).getOrThrow()
            deltas.append(delta) // add the first Delta to the current set
            // if there's more than 1 Delta, we may need to output them together
            if (patchDeltas.size > 1) {
                var i = 1
                while (i < patchDeltas.size) {
                    var position = delta.getOriginal().getPosition() 
                    // store
                    // the
                    // current
                    // position
                    // of
                    // the first Delta
                    // Check if the next Delta is too close to the current
                    // position.
                    // And if it is, add it to the current set
                    var nextDelta: Delta<String> = patchDeltas.get(i).getOrThrow()
                    if ((position + delta.getOriginal().size() + contextSize) >= (nextDelta
                            .getOriginal().getPosition() - contextSize)) {
                        deltas.append(nextDelta)
                    } else {
                        // if it isn't, output the current set,
                        // then create a new set and add the current Delta to
                        // it.
                        var curBlock: ArrayList<String> = processDeltas(originalLines,
                                deltas, contextSize)
                        ret.appendAll(curBlock)
                        deltas.clear()
                        deltas.append(nextDelta)
                    }
                    delta = nextDelta
                    i++
                }

            }
            // don't forget to process the last set of Deltas
            var curBlock: ArrayList<String> = processDeltas(originalLines, deltas,
                    contextSize)
            ret.appendAll(curBlock)
            return ret
        }
        return ArrayList<String>()
    }