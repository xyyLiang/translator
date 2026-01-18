    public static func unpatch<T>(revised: ArrayList<T>, patch: Patch<T>): ArrayList<T>
            where T <: Equal<T> & ToString{
        return patch.restore(revised)
    }