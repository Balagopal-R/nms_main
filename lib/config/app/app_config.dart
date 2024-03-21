import 'package:flutter/foundation.dart';
import '../../flavors.dart';

@immutable
class NMSAppConfig {
  final String backendBaseURL;
  final String serviceUrl;
  final String httpScheme;

  // final String encryptKey;
  // final String googleApiKey;

  const NMSAppConfig({
    required this.backendBaseURL,
    required this.serviceUrl,
    required this.httpScheme,
    // required this.encryptKey,
    // required this.googleApiKey
  });
}

class NMSAppConfigManager {
  static NMSAppConfig _getDevConfig() {
    return const NMSAppConfig(
      backendBaseURL: "13.200.132.41:7070",
      serviceUrl: "api/v1",
      httpScheme: "http",
      // encryptKey: "jsbrandomsecretk",
      // googleApiKey: "AIzaSyDXTOjW4E9tgwpNxe37vtmgsq3ChE4BVz4",
    );
  }

  static NMSAppConfig _getProdConfig() {
    return const NMSAppConfig(
      backendBaseURL: "13.200.132.41:7070",

      serviceUrl: "api/v1",
      httpScheme: "http",
      // encryptKey: "jsbrandomsecretk",
      // googleApiKey: "AIzaSyDXTOjW4E9tgwpNxe37vtmgsq3ChE4BVz4",
    );
  }

  static final NMSAppConfig _instance = _getConfig();
  static NMSAppConfig _getConfig() {
    NMSAppConfig config;
    switch (F.appFlavor) {
      case Flavor.dev:
        config = _getDevConfig();
        break;
      case Flavor.prod:
        config = _getProdConfig();
        break;
      default:
        config = _getDevConfig();
        break;
    }
    return config;
  }

  static NMSAppConfig get config => _instance;
}
