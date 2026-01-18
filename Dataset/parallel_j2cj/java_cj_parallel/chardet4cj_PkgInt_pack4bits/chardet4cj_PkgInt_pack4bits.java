    public static int pack4bits(int a, int b, int c, int d, int e, int f, int g, int h)
    {
        return pack8bits(
                (b << 4) | a,
                (d << 4) | c,
                (f << 4) | e,
                (h << 4) | g
                );
    }