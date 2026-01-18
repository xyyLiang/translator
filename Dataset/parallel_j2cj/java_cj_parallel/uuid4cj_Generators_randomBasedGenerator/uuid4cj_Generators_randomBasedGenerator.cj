    public static func randomBasedGenerator():RandomBasedGenerator{
        return  RandomBasedGenerator(LazyRandom.sharedSecureRandom())
    }