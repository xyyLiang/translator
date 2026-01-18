    func getRandomInteger(): Int32 {
        RANDOM.seed = DEFAULT_NUM
        return RANDOM.nextInt32()
    }