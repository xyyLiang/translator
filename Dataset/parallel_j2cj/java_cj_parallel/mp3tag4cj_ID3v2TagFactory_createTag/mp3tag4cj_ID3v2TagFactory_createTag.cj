    public static func createTag(bytes: Array<Int8>): Option<AbstractID3v2Tag> {
        sanityCheckTag(bytes);

        //对bytes标签头头内容进行检查，包括标签头长度10字节， 前3个字节的内容， 和子版本好进行检查
        var majorVersion: Int8 = bytes[Int64(AbstractID3v2Tag.MAJOR_VERSION_OFFSET)]

        //获得第4个字节的子版本号，也就是ID3 后面的一个字节
        match (majorVersion) {
            // 安装子版本创建标签, 各个子版本都继承了AbstractID3v2Tag抽象类，重写了不同方法
            case 2 => return createID3v22Tag(bytes)
            case 3 => return Option<AbstractID3v2Tag>.Some(ID3v23Tag(bytes))
            case 4 => return Option<AbstractID3v2Tag>.Some(ID3v24Tag(bytes))
            case _ => throw UnsupportedTagException("Tag version not supported")
        }
    }
