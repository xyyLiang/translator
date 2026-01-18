    public void visit(final CommandVisitor<T> visitor) {
        commands.forEach(command -> command.accept(visitor));
    }