    public init(
        fieldName: String,
        contentType: String,
        isFormField: Bool,
        fileName: String,
        sizeThreshold: Int64,
        repository: Option<Directory>
    ) {
        this.fieldName = fieldName
        this.contentType = contentType
        this.isFormField = isFormField
        this.fileName = fileName
        this.sizeThreshold = sizeThreshold
        this.repository = repository
    }