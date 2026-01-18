    protected func close(pCloseUnderlying: Bool): Unit {
        if (closed) {
            return
        }

        if (pCloseUnderlying) {
            closed = true
        } else {
            while (true) {
                var av = available()
                if (av == 0) {
                    av = makeAvailable()
                    if (av == 0) {
                        break
                    }
                }
                skip(av)
            }
        }
        closed = true
    }