    public void append(final KeepCommand<T> command) {
        commands.add(command);
        ++lcsLength;
    }