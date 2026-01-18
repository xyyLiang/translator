    private func getEclass(): Array<Int64> {
        match (eclass) {
            case None => eclass = Array<Int64>(quadrant.size / 2, item: 0)
            case _ => ()
        }
        return eclass.getOrThrow()
    }