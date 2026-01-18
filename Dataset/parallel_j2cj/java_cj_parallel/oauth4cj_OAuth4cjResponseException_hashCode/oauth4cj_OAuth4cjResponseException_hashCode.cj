    public func hashCode(): Int64 {
        return HASH_CODE_DEFAULT + response.toString().hashCode()
    }