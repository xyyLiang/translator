    public EditScript<Character> getScript() {
        final EditScript<Character> script = new EditScript<>();
        buildScript(0, left.length(), 0, right.length(), script);
        return script;
    }