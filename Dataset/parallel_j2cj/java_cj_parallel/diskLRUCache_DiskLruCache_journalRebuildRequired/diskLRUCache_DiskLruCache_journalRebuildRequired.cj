    private func journalRebuildRequired(): Bool {
        let redundantOpCompactThreshold = 2000
        return redundantOpCount >= redundantOpCompactThreshold && redundantOpCount >= lruEntries.size
    }