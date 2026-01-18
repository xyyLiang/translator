    @Override
    public UUID generate(byte[] nameBytes)
    {
        byte[] digest;
        synchronized (_digester) {
            _digester.reset();
            if (_namespace != null) {
                _digester.update(UUIDUtil.asByteArray(_namespace));
            }
            _digester.update(nameBytes);
            digest = _digester.digest();
        }
        return UUIDUtil.constructUUID(_type, digest);
    }
}