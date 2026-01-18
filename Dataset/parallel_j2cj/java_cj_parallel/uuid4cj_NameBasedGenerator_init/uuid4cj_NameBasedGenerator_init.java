    public NameBasedGenerator(UUID namespace, MessageDigest digester, UUIDType type)
    {
        _namespace = namespace;
        // And default digester SHA-1
        if (digester == null) {
            throw new IllegalArgumentException("Digester not optional: cannot pass `null`");
        }
        if (type == null) {
            String typeStr = digester.getAlgorithm();
            if (typeStr.startsWith("MD5")) {
                type = UUIDType.NAME_BASED_MD5;
            } else if (typeStr.startsWith("SHA")) {
                type = UUIDType.NAME_BASED_SHA1;
            } else {
                // Hmmh... error out? Let's default to SHA-1, but log a warning
                type = UUIDType.NAME_BASED_SHA1;
                _logger.warn("Could not determine type of Digester from '%s'; assuming 'SHA-1' type", typeStr);
            }
        }
        _digester = digester;
        _type = type;
    }