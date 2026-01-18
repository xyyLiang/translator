    public func toString(): String {
        if (let Some(_) <- getStoreLocation()) {
            return "name=" + getName() + " StoreLocation=" + getStoreLocation().getOrThrow().info.path.toString() + " size="+
                getSize().toString() + " bytes isFormField=" + isGetFormField().toString() + " FieldName=" +
                getFieldName()
        } else {
            return "name=" + getName() + " size=" + getSize().toString() + " bytes isFormField=" +
                isGetFormField().toString() + " FieldName=" + getFieldName()
        }
    }