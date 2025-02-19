class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      question: json['question'],
      answer: json['answer'],
    );
  }
}

class Video {
  final String url;
  final String thumbnail;
  final String title;
  final double aspectRatio;

  Video(
      {required this.url,
      required this.thumbnail,
      required this.title,
      required this.aspectRatio});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        url: json['sources'],
        thumbnail: json['thumb'],
        title: json['title'],
        aspectRatio: json['aspect_ratio']);
  }
}

class SupportFaq {
  final List<FAQ> faq;
  final List<Video> videos;

  SupportFaq({required this.faq, required this.videos});

  factory SupportFaq.fromJson(Map<String, dynamic> json) {
    var faqList = json['faq'] as List;
    var videoList = json['videos'] as List;

    List<FAQ> faq = faqList.map((i) => FAQ.fromJson(i)).toList();
    List<Video> videos = videoList.map((i) => Video.fromJson(i)).toList();

    return SupportFaq(
      faq: faq,
      videos: videos,
    );
  }
}
