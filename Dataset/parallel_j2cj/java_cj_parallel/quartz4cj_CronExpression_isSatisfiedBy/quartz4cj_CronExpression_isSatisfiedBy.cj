    public func isSatisfiedBy(date0: DateTime): Bool {
        let originalDate = resetMillis(date0)
        let testDate = originalDate.addSeconds( -1 )
        let timeAfter = getTimeAfter(testDate)
        return timeAfter == Some(originalDate)
    }