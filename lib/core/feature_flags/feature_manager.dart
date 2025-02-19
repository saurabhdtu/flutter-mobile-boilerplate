import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:zinc/core/feature_flags/feature_flag_model.dart';

class FeatureManager {
  final FirebaseRemoteConfig remoteConfig;

  FeatureResponse? _featureResponse;

  FeatureManager({required this.remoteConfig});

  // Initialize and fetch remote config
  Future<void> initialize() async {
    // Dummy JSON to use as default values
    await remoteConfig.setDefaults(<String, dynamic>{
      'features': jsonEncode({
        "remittance": {
          "enabled": true,
          "send_money": {
            "enabled": true,
            "send_local": {
              "enabled": true
            },
            "send_international": {
              "enabled": true
            }
          },
          "add_beneficiary": {
            "enabled": true
          },
          "add_remitter": {
            "enabled": true
          },
          "transaction_history": {
            "enabled": true
          }
        },
        "airwallex": {
          "enabled": true,
          "add_card": {
            "enabled": true,
            "block_card": {
              "enabled": true
            },
            "freeze_card": {
              "enabled": true
            },
            "limit_card": {
              "enabled": true
            }
          },
          "add_beneficiary": {
            "enabled": true
          },
          "make_payment": {
            "enabled": true
          }
        }
      })
    });
    await remoteConfig.fetchAndActivate();
    String featureFlagsJson = remoteConfig.getString('features');
    _featureResponse = FeatureResponse.fromJson(jsonDecode(featureFlagsJson));
  }

  // General method to check if a feature is enabled by path
  bool isFeatureEnabled(String featurePath) {
    if (_featureResponse == null) {
      throw Exception("Feature flags are not initialized yet.");
    }

    final keys = featurePath.split('.');
    dynamic currentFeature = _featureResponse;

    for (var key in keys) {
      if (currentFeature == null) {
        return false;
      }

      switch (key) {
        case 'remittance':
          currentFeature = currentFeature.remittance;
          break;
        case 'send_money':
          currentFeature = currentFeature.sendMoney;
          break;
        case 'send_local':
          return currentFeature.sendLocal?.enabled ?? false;
        case 'send_international':
          return currentFeature.sendInternational?.enabled ?? false;
        case 'add_beneficiary':
          currentFeature = currentFeature.addBeneficiary;
          break;
        case 'add_remitter':
          currentFeature = currentFeature.addRemitter;
          break;
        case 'transaction_history':
          currentFeature = currentFeature.transactionHistory;
          break;
        case 'airwallex':
          currentFeature = currentFeature.airwallex;
          break;
        case 'add_card':
          currentFeature = currentFeature.addCard;
          break;
        case 'block_card':
          return currentFeature.blockCard?.enabled ?? false;
        case 'freeze_card':
          return currentFeature.freezeCard?.enabled ?? false;
        case 'limit_card':
          return currentFeature.limitCard?.enabled ?? false;
        case 'make_payment':
          currentFeature = currentFeature.makePayment;
          break;
        default:
          return false;
      }
    }

    return currentFeature?.enabled ?? false;
  }

  // Specific feature checks
  bool isSendMoneyEnabled() {
    return isFeatureEnabled('remittance.send_money');
  }

  bool isAddBeneficiaryEnabled() {
    return isFeatureEnabled('remittance.add_beneficiary');
  }

  bool isTransactionHistoryEnabled() {
    return isFeatureEnabled('remittance.transaction_history');
  }

  bool isAddCardEnabled() {
    return isFeatureEnabled('airwallex.add_card');
  }

  bool isBlockCardEnabled() {
    return isFeatureEnabled('airwallex.add_card.block_card');
  }

  bool isMakePaymentEnabled() {
    return isFeatureEnabled('airwallex.make_payment');
  }

// Add more specific methods as needed
}
