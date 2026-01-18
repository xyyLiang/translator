    public static NameBasedGenerator nameBasedGenerator(UUID namespace, MessageDigest digester)
    {
        UUIDType type = null;
        if (digester == null) {
            try {
                digester = MessageDigest.getInstance("SHA-1");
                type = UUIDType.NAME_BASED_SHA1;
            } catch (NoSuchAlgorithmException nex) {
                throw new IllegalArgumentException("Couldn't instantiate SHA-1 MessageDigest instance: "+nex.toString());
            }
        }
        return new NameBasedGenerator(namespace, digester, type);
    }