    private func initialize( filename: String) : Unit  {
        // short-circuit if already initialized
        if (cfgOpt.isPresent()) {
            return;
        }
        if ( let Some(initException) <- initExceptionOpt) {
            throw initException;
        }

        let props = Properties(filename) 

        propSrc = "the specified file : '" + filename + "'";

        initialize(props);
    }