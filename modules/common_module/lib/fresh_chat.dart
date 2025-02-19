import 'package:common_module/common_constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:freshchat_sdk/freshchat_user.dart';

class FreshchatService {
  static void initializeFreshchat() {
    Freshchat.init(
      CommonConstant.freshchatAppId,
      CommonConstant.freshchatAppKey,
      CommonConstant.freshchatDomain,
      teamMemberInfoVisible: true,
      cameraCaptureEnabled: true,
      gallerySelectionEnabled: true,
      responseExpectationEnabled: true,
    );
    FreshchatService.setNotificationTokenFreshchat();
  }

  static void setUser({
    required String firstName,
    required String lastName,
    required String email,
    required String countryCode,
    required String phoneNumber,
  }) {
    FreshchatUser freshchatUser = FreshchatUser(null, null);
    freshchatUser.setFirstName(firstName);
    freshchatUser.setLastName(lastName);
    freshchatUser.setEmail(email);
    freshchatUser.setPhone(countryCode, phoneNumber);
    Freshchat.setUser(freshchatUser);
  }

  static void showFAQ() {
    Freshchat.showFAQ(showFaqCategoriesAsGrid: false);
  }

  static void showConversation(
      {String? filteredViewTitle, List<String>? tags}) {
    Freshchat.showConversations(
        filteredViewTitle: filteredViewTitle, tags: tags);
  }

//silently send a message and not launch the Freshchat SDK UI
  static void sendMessage(String tag, String message) {
    Freshchat.sendMessage(tag, message);
  }

  static Future<void> setNotificationTokenFreshchat() async {
    Freshchat.setPushRegistrationToken(
        await FirebaseMessaging.instance.getToken() ?? '');
    FirebaseMessaging.onMessage.listen((message) async {
      if (await Freshchat.isFreshchatNotification(message.data)) {
        Freshchat.handlePushNotification(message.data);
      }
    });
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  static Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
    Freshchat.handlePushNotification(message.data);
  }
}
