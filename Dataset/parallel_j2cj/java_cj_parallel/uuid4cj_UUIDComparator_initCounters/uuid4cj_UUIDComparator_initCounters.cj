    private func initCounters(rnd:SecureRandom):Unit{
        _clockSequence = rnd.nextInt32()
        _clockCounter = (_clockSequence >> 16) & 0xFF
    }