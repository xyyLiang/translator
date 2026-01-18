    private func fvswap(fmap: Array<Int64>, yyp1i64: Int64, yyp2i64: Int64, yyni64: Int64): Unit {
        var (yyp1, yyp2, yyn) = (yyp1i64, yyp2i64, yyni64)
        while (yyn > 0) {
            fswap(fmap, yyp1, yyp2)
            yyp1++
            yyp2++
            yyn--
        }
    }