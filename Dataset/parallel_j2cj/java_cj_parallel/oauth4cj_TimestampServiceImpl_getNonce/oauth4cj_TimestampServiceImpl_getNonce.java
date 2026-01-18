    @Override
    public String getNonce() {
        final Long ts = getTs();
        return String.valueOf(ts + timer.getRandomInteger());
    }