    public override func createItem(fieldName: String, contentType: String, isFormField: Bool, fileName: String): FileItem {
        return DiskFileItem(fieldName, contentType, isFormField, fileName, sizeThreshold, repository)
    }