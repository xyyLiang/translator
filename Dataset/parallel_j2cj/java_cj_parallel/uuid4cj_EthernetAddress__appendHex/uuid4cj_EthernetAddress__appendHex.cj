    private func _appendHex(sb:StringBuilder,hex:Int64):Unit{
        sb.append(HEX_CHARS[(hex >> 4) & 0xF])
        sb.append(HEX_CHARS[(hex & 0x0f)])
    }