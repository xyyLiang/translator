  static VersionSize getVersionSize(Version version) {
    return version.getVersionNumber() <= 9 ? VersionSize.SMALL : version.getVersionNumber() <= 26 ?
      VersionSize.MEDIUM : VersionSize.LARGE;
  }