    public int unpack(int i)
    {
        return (
                (this.data[i>>this.indexShift] >> ((i&this.shiftMask)<<this.bitShift)) & this.unitMask
                );
    }