    public open func setFooter(footer: Bool): Unit {
        if (this.footer != footer) {
            invalidateDataLength()
            this.footer = footer
        }
    }