    private void initCounters(Random rnd)
    {
        _clockSequence = rnd.nextInt();
        _clockCounter = (_clockSequence >> 16) & 0xFF;
    }