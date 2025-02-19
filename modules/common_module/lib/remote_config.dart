import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigManager {
  static RemoteConfigManager? _instance;
  late FirebaseRemoteConfig remoteConfig;

  RemoteConfigManager._();

  static RemoteConfigManager get getInstance =>
      _instance ??= RemoteConfigManager._();

  Future<bool> init(FirebaseRemoteConfig remoteConfig) async {
    this.remoteConfig = remoteConfig;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: kDebugMode ? 1 : 180)));
    await remoteConfig.setDefaults({
      RemoteConfigKeys.urls:
          "{\"faq_url\":\"https:\/\/zincmoneypvtltd.freshdesk.com\/support\/home\",\"privacy_policy\":\"https:\/\/www.zinc.money\/privacy-policy\",\"tos\":\"https:\/\/www.zinc.money\/terms\",\"contact_no\":\"tel:\/\/+918422854475\",\"website\":\"https:\/\/www.zinc.money\",\"contact_email\":\"mailto:support@z.inc\"}",
      RemoteConfigKeys.appVersion:
          "{\"versionCode\":{\"ios\":\"1.0.1\",\"android\":\"1.0.1\"},\"versionNumber\":{\"ios\":1,\"android\":1},\"minAppVersionNumber\":{\"ios\":1,\"android\":1}}",
      RemoteConfigKeys.homePageConfigNewUser:
          "{\"top_header\":{\"title\":\"Send money\\nacross borders\",\"cta\":\"Send\"},\"value_proposition\":{\"title\":\"Across borders, with ease\",\"bg_color\":\"#FFFFFF\",\"items\":[{\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/banner01.png\",\"image_ratio\":1.15},{\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/banner02.png\",\"image_ratio\":1.15},{\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/banner03.png\",\"image_ratio\":1.15},{\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/banner04.png\",\"image_ratio\":1.15},{\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/banner05.png\",\"image_ratio\":1.15}]},\"reliable\":{\"title\":\"Reliable and safe way to pay international college fees\",\"description\":\"Guaranteed transfer in 48hrs with simple account setup and timely reminders.\",\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/img_security.png\",\"image_ratio\":1.418},\"value_comparison\":{\"title\":\"Zinc guarantees lowest forex charges and zero bank fees\",\"description\":\"Found a cheaper option? We will match it!\",\"items\":[{\"title\":\"Zinc\",\"price\":\"\u20B97,55,550\",\"rate\":\"@83.95 \u30FBZERO Bank fee\"},{\"title\":\"Flywire\",\"price\":\"\u20B97,59,880\",\"difference\":\"+6%\",\"rate\":\"@84.32 \u30FB\u20B91,000 fee\"},{\"title\":\"MoneyHop\",\"price\":\"\u20B97,58,930\",\"difference\":\"+5%\",\"rate\":\"@84.02 \u30FB\u20B92,750 fee\"},{\"title\":\"Bookmyforex\",\"price\":\"\u20B97,57,265\",\"difference\":\"+4%\",\"rate\":\"@84.05 \u30FB\u20B9815 fee\"}]},\"secured\":{\"title\":\"Secured by IDBI bank, assured by Zinc\",\"description\":\"Make secure and fully encrypted payments - compliant with all regulations.  \",\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/banner-trust-idbi.png\",\"image_ratio\":1.09},\"we_asked\":{\"title\":\"In the age of 10min home deliveries and instantaneous  UPI payments, why can\u2019t cross border payments be simpler?\",\"bg_color\":\"#FFFFFF\"},\"upi\":{\"title\":\"Introducing UPI for international payments\",\"description\":\"One tap authentication & quick transfers with the power of UPI\",\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/UPI-banner.png\",\"image_ratio\":0.95},\"send_money\":{\"title\":\"Send money abroad in 3 simple steps\",\"bg_image\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/img_bg_send_money.png\",\"description\":\"With one tap authentication & seamless process to add multiple senders & receivers\",\"items\":[{\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/img_send_money_banner_1.png\",\"image_ratio\":0.98},{\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/img_send_money_banner_2.png\",\"image_ratio\":0.98},{\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/img_send_money_banner_3.png\",\"image_ratio\":0.98}]},\"reward\":{\"title\":\"Studying abroad? Your laptop is on us\",\"description\":\"Save upto \u20B91,68,000 in four years with guaranteed savings on each payment.\",\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/img_reward.png\",\"image_ratio\":1.08},\"payment_status\":{\"title\":\"Your payment status: running on time\",\"description\":\"Live tracking of your payments, shareable links and timely notifications\",\"bg_image\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/img_bg_status.png\",\"lottie\":\"lottie_file\"},\"your_money_24x7\":{\"title\":\"Your money works for you 24x7, so do our experts\",\"description\":\"From setup, payments to documents - our experts are here to help you!\",\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/home_screen\/Support-chat.png\",\"image_ratio\":1.09}}",
      RemoteConfigKeys.homePageConfigOldUser:
          "{\"top_header\":{\"formatted_title\":[{\"text\":\"Send money\\nacross borders\",\"color\":\"#C0FFE3\"}],\"description\":\"Yay! You\u2019ll get Flat 100% of Bank fee\",\"cta\":\"Start payment\"},\"continue\":{\"formatted_title\":[{\"text\":\"Continue\",\"color\":\"#000000\"}]},\"send_again\":{\"formatted_title\":[{\"text\":\"Send again\",\"color\":\"#000000\"}]},\"quick_send\":{\"formatted_title\":[{\"text\":\"Quick send\",\"color\":\"#000000\"}]},\"suggested\":{\"formatted_title\":[{\"text\":\"Suggested for you\",\"color\":\"#000000\"}],\"cta\":\"Explore now\"},\"quick_actions\":{\"formatted_title\":[{\"text\":\"Quick actions\",\"color\":\"#000000\"}],\"items\":[{\"title\":\"Transaction history\",\"description\":\"View your transaction history\",\"url\":\"\/transactions\"},{\"title\":\"Manage senders\",\"description\":\"View and manage senders\",\"url\":\"\/senders\"}]},\"videos\":{\"formatted_title\":[{\"text\":\"Popular videos for you\",\"color\":\"#000000\"}],\"items\":[{\"title\":\"Understand taxation (TCS)\",\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/img_video_thumbnail-2.jpg\",\"youtube_video_id\":\"WYfA500GDQY\"},{\"title\":\"Know about forex rate\",\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/img_video_thumbnail-2.jpg\",\"youtube_video_id\":\"WYfA500GDQY\"},{\"title\":\"What is zinc?\",\"image_url\":\"https:\/\/storage.googleapis.com\/zinc-money-prod.appspot.com\/app-image-assets\/img_video_thumbnail-2.jpg\",\"youtube_video_id\":\"WYfA500GDQY\"}]},\"value_comparison\":{\"formatted_title\":[{\"text\":\"Get the best value,\\n\",\"color\":\"#000000\"},{\"text\":\"across the board\",\"color\":\"#10AB48\"}],\"items\":[{\"title\":\"Zinc\",\"price\":\"\u20B97,55,550\",\"rate\":\"@83.95 \u30FBZERO Bank fee\"},{\"title\":\"Flywire\",\"price\":\"\u20B97,59,880\",\"difference\":\"+6%\",\"rate\":\"@84.32 \u30FB\u20B91,000 fee\"},{\"title\":\"MoneyHop\",\"price\":\"\u20B97,58,930\",\"difference\":\"+5%\",\"rate\":\"@84.02 \u30FB\u20B92,750 fee\"},{\"title\":\"Bookmyforex\",\"price\":\"\u20B97,57,265\",\"difference\":\"+4%\",\"rate\":\"@84.05 \u30FB\u20B9815 fee\"}]}}",
      RemoteConfigKeys.receiverReasonList:
          "{\"title_tag\":\"AddReceiver\",\"title\":\"Whyareyousendingthemoneyacross?\",\"sub_title\":\"Chooseareasontoproceed\",\"reason_list\":[{\"tag\":\"\",\"text\":\"Student’sownaccount\",\"sub_text\":\"Sendforrentpaymentandexpenses\"},{\"tag\":\"\",\"text\":\"Tuitionfee\",\"sub_text\":\"Sendtouniversitybankaccount\"},{\"tag\":\"Germanyonly\",\"text\":\"Blockedaccount\",\"sub_text\":\"Sendtostudent’sblockedaccount\"},{\"tag\":\"CANADAonly\",\"text\":\"GIC\",\"sub_text\":\"Sendtostudent’sGICaccount\"}]}",
      RemoteConfigKeys.remittanceBetaUsers:
          "{\"beta_enabled\":true,\"beta_users\":[\"8558937322\",\"8884872752\",\"9611499448\",\"8298539713\",\"8859167328\",\"9833608225\",\"9987588772\",\"7728860882\",\"7200102734\",\"9538027518\",\"8168388930\",\"8808192257\",\"7045811392\",\"9769090515\",\"7208193329\",\"8422854476\",\"9029852858\",\"9950394789\",\"7014012231\",\"9650076366\",\"9620111137\",\"7708548432\",\"9400936098\",\"7550249936\",\"7907920347\",\"9900252411\",\"9446215469\",\"9567889969\",\"9446667062\",\"8078352401\",\"8137986118\",\"9947070522\",\"7483423184\",\"9729665590\",\"9566293823\",\"8852078989\",\"9811160841\",\"9341811430\",\"7012849657\",\"9999999999\",\"9999999998\"]}",
      RemoteConfigKeys.downloadableAssetList: "{}",
      RemoteConfigKeys.aWXCardLandingList: "{}",
      RemoteConfigKeys.paymentReasons:
          "[{\"id\":1,\"text\":\"\u2708\uFE0F Work\"},{\"id\":2,\"text\":\"\uD83C\uDFD6\uFE0F \uFE0FVacation\"},{\"id\":3,\"text\":\"\uD83D\uDCD6 Study\"},{\"id\":4,\"text\":\"\uD83D\uDCD6 Investment\"},{\"id\":5,\"text\":\"Other\"}]"
    });
    return remoteConfig.fetchAndActivate();
  }

  T getJsonData<T>(String key, T Function(dynamic) mapper) {
    final value = remoteConfig.getString(key);
    return mapper.call(jsonDecode(value));
  }

  bool getBoolFlag(String key) => remoteConfig.getBool(key);
}

abstract class RemoteConfigKeys {
  static const urls = "urls";
  static const bankIcons = "bank_icons";
  static const featureFlags = "feature_flags";
  static const appVersion = "app_version";
  static const homePageConfigNewUser = "home_page_config_new_user";
  static const homePageConfigOldUser = "home_page_config_old_user";
  static const receiverReasonList = "receiver_reason_list";
  static const remittanceBetaUsers = "remittance_beta_users";
  static const supportFaq = "faq_support";
  static const downloadableAssetList = "downloadable_asset_list";
  static const avatars = "avatars";
  static const aWXCardLandingList = "awx_card_landing_list";
  static const paymentReasons = "payment_reasons";
  static const profileList = "profile_list";
  static const appConfig = "app_config";
  static const onboardingConfiguration = "onboarding_configuration";
}
