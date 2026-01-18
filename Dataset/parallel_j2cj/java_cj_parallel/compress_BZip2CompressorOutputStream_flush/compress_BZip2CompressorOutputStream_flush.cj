    public override func flush(): Unit {
        let outShadow: OutputStream = this.out
        outShadow.flush()
    }