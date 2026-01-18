    private final void _appendHex(StringBuilder sb, int hex)
    {
        sb.append(HEX_CHARS[(hex >> 4) & 0xF]);
        sb.append(HEX_CHARS[(hex & 0x0f)]);
    }