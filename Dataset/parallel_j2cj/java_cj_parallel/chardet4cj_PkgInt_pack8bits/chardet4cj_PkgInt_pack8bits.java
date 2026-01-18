    public static int pack8bits(int a, int b, int c, int d)
    {
        return pack16bits(
                (b << 8) | a,
                (d << 8) | c
                );
    }