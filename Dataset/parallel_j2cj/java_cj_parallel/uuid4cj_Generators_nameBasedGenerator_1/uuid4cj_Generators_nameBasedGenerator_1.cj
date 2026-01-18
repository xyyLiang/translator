    public static func nameBasedGenerator(namespace: UUID): NameBasedGenerator {
        return NameBasedGenerator(namespace, Option<MessageDigest>.None, Option<UUIDType>.None)
    }