    @Override
    public String toString() {
        return String.format("@Request(%s %s)", getVerb(), getUrl());
    }