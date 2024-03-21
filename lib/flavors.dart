enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'NMSDev';
      case Flavor.prod:
        return 'NMS';
      default:
        return 'title';
    }
  }

}
