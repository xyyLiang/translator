    public init(unsynchronisation: Bool, language: Option<String>, description: Option<EncodedText>, 
        comment: Option<EncodedText>) {
        super(unsynchronisation)
        if (description != Option<EncodedText>.None) {
            if (comment != Option<EncodedText>.None) {
                if (description.getOrThrow().getTextEncoding() != comment.getOrThrow().getTextEncoding()) {
                    throw Exception("description and comment must have same text encoding")
                }
            }
        }
        this.language = language
        this.description = description
        this.comment = comment
    }