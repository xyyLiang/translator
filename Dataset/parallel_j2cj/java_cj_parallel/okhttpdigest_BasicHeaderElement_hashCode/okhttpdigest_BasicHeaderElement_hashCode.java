    public int hashCode() {
        byte hash = 17;
        int var3 = LangUtils.hashCode(hash, this.name);
        var3 = LangUtils.hashCode(var3, this.value);

        for (int i = 0; i < this.parameters.length; ++i) {
            var3 = LangUtils.hashCode(var3, this.parameters[i]);
        }

        return var3;
    }