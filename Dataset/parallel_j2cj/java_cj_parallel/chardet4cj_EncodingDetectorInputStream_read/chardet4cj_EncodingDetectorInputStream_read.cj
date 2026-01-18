    public func read(): Int64 { 
        var data: Array<Byte> = Array<Byte>((input as Seekable).getOrThrow().length, item: 0)
        var nrOfBytesRead: Int64 = this.read(data,0,1)
        if (nrOfBytesRead > 0){
            return Int64(data[0])
        }
        return -1
    }