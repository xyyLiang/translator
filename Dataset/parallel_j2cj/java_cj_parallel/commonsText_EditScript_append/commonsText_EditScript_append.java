    public void append(final DeleteCommand<T> command) {
        commands.add(command);
        ++modifications;
    }