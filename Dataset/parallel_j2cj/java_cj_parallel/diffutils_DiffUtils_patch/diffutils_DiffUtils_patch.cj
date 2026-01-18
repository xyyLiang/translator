    public static func patch<T>(original: ArrayList<T>, patch: Patch<T>): ArrayList<T> 
            where T <: Equal<T> & ToString{
        return patch.applyTo(original)
    }