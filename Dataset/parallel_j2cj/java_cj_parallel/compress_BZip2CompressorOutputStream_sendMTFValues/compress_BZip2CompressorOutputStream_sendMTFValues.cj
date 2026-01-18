    private func sendMTFValues(): Unit {
        let len: Array<Array<Byte>> = this.data.sendMTFValues_len
        let alphaSize: Int64 = this.nInUse + 2

        for (t in (N_GROUPS - 1)..=0 : -1) {
            let len_t: Array<Byte> = len[t]
            for (v in alphaSize - 1..=0 : -1) {
                len_t[v] = GREATER_ICOST
            }
        }

        /* Decide how many coding tables to use */
        let nGroups: Int64 = if (this.nMTF < 200) {
            2
        } else if (this.nMTF < 600) {
            3
        } else if (this.nMTF < 1200) {
            4
        } else if (this.nMTF < 2400) {
            5
        } else {
            6
        }

        // Generate an initial set of coding tables.
        sendMTFValues0(nGroups, alphaSize)

        // Iterate up to N_ITERS times to improve the tables.
        let nSelectors: Int64 = sendMTFValues1(nGroups, alphaSize)

        // Compute MTF values for the selectors.
        sendMTFValues2(nGroups, nSelectors)

        // Assign actual codes for the tables.
        sendMTFValues3(nGroups, alphaSize)

        // Transmit the mapping table.
        sendMTFValues4()

        // Now the selectors.
        sendMTFValues5(nGroups, nSelectors)

        // Now the coding tables.
        sendMTFValues6(nGroups, alphaSize)

        // And letly, the block data proper.
        sendMTFValues7()
    }