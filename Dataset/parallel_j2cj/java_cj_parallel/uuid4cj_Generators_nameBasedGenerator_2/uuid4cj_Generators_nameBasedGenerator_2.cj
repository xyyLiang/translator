    public static func nameBasedGenerator(namespace: UUID, digester: MessageDigest): NameBasedGenerator {
        return NameBasedGenerator(namespace, digester, Option<UUIDType>.None)
    }