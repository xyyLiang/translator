    public func runningSince(): ?DateTime  {
        match( initialStart ) {
            case Some(t) => t
            case _ => None
        }
    }