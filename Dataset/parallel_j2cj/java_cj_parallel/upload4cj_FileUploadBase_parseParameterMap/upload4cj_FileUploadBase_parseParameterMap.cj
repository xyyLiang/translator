    public func parseParameterMap(ctx: RequestContext): Map<String, ArrayList<FileItem>> {
        let items: ArrayList<FileItem> = parseRequest(ctx).getOrThrow()
        let itemsMap: Map<String, ArrayList<FileItem>> = HashMap<String, ArrayList<FileItem>>()
        for (fileItem in items) {
            let fieldName: String = fileItem.getFieldName()
            var mappedItems: Option<ArrayList<FileItem>> = itemsMap.get(fieldName)
            if (let Some(i) <- mappedItems) {
                i.append(fileItem)
            } else {
                mappedItems = ArrayList<FileItem>()
                itemsMap.put(fieldName, mappedItems.getOrThrow())
                mappedItems.getOrThrow().append(fileItem)
            }
        }
        return itemsMap
    }