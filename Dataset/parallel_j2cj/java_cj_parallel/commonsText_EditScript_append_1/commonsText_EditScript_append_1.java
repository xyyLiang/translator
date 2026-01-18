    public void append(final InsertCommand<T> command) {
        commands.add(command);
        ++modifications;
    }