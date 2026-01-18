    private func trimToSize(): Unit {
        while (size > maxSize) {
            let toEvict: String = lruEntries.keys().iterator().next().getOrThrow()
            remove(toEvict)
        }
    }