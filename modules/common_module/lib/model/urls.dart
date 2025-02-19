class   AppURLs {
  AppURLs({this.faqUrl, this.privacyPolicy, this.tos, this.contactNum, this.website, this.contactEmail});

  AppURLs.fromJson(dynamic json) {
    faqUrl = json['faq_url'];
    privacyPolicy = json['privacy_policy'];
    tos = json['tos'];
    contactNum = json['contact_no'];
    contactEmail = json['contact_email'];
    website = json['website'];
  }

  String? faqUrl;
  String? privacyPolicy;
  String? tos;
  String? contactNum;
  String? contactEmail;
  String? website;
}
