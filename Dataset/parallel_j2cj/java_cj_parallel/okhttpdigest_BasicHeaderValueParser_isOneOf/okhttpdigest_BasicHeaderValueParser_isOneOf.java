    private static boolean isOneOf(char ch, char[] chs) {
        if(chs != null) {
            char[] arr$ = chs;
            int len$ = chs.length;

            for(int i$ = 0; i$ < len$; ++i$) {
                char ch2 = arr$[i$];
                if(ch == ch2) {
                    return true;
                }
            }
        }

        return false;
    }