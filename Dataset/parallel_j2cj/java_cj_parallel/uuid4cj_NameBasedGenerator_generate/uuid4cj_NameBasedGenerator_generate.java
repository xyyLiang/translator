    @Override
    public UUID generate(String name)
    {
        return generate(name.getBytes(_utf8));
    }