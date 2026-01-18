    public static func fromString(name: String): UUID {
        let components: Array<String> = name.split("-")
        if (components.size != 5) {
            throw IllegalArgumentException("Invalid UUID string: " + name)
        }
        let hexStr = String.join(components)
        if (hexStr.size != 32) {
           throw IllegalArgumentException("Invalid UUID string: " + name)
        }
        let data = match(fromHexString(hexStr)) {
            case Some(value) => value
            case None => throw IllegalArgumentException("Invalid UUID string: " + name)
        }
        let uuid = UUID(data)
        return uuid

    }