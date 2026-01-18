    public override func getContentType(): String {
        if (let Some(i) <- contentType) {
            return i
        } else {
            return ""
        }
    }