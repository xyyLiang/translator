    public func previousSnake(): Option<PathNode> {
        if (isBootstrap()) {
            return Option<PathNode>.None
        }
        if (!isSnake()) {
            match(prev) {
                case Some(v) => return v.previousSnake()
                case None => return this
            }
        }
        return this
    }