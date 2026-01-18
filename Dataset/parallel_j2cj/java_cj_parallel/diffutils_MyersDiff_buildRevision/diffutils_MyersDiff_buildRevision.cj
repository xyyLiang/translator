    public func buildRevision(path: PathNode, orig: ArrayList<T>, rev: ArrayList<T>): Patch<T> {
        var temppath: Option<PathNode> = Option<PathNode>.Some(path)
        var patch: Patch<T> = Patch<T>()
        if (path.isSnake()) {
            temppath = path.prev
        }
        while (!checkNull(temppath) && !checkNull(temppath.getOrThrow().prev) && temppath.getOrThrow().prev.getOrThrow().j >= 0) {
            if (temppath.getOrThrow().isSnake()) {
                throw DifferentiationFailedException("bad diffpath, found snake when looking for diff")
            }
            var i = temppath.getOrThrow().i
            var j = temppath.getOrThrow().j

            temppath = temppath.getOrThrow().prev
            var ianchor = temppath.getOrThrow().i
            var janchor = temppath.getOrThrow().j

            var original: Chunk<T> = Chunk<T>(ianchor, copyOfRange(orig, ianchor, i))
            var revised: Chunk<T> = Chunk<T>(janchor, copyOfRange(rev, janchor, j))
            var delta: Delta<T>
            if (original.size() == 0 && revised.size() != 0) {
                delta =  InsertDelta<T>(original, revised)
            } else if (original.size() > 0 && revised.size() == 0) {
                delta = DeleteDelta<T>(original, revised)
            } else {
                delta = ChangeDelta<T>(original, revised)
            }
            patch.addDelta(delta)
            if (temppath.getOrThrow().isSnake()) {
                temppath = temppath.getOrThrow().prev
            }
        }
        return patch
    }
