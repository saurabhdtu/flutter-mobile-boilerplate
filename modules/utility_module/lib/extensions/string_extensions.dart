import 'dart:math';

import 'package:flutter/material.dart';
import 'package:utility_module/logger/logger.dart';

extension NullStringUtils on String? {
  bool isEmptyOrNull() => this == null || this?.isEmpty == true;

  String initials() {
    if (isEmptyOrNull()) {
      return "";
    }
    List<String> words = this!.split(' ');
    String initials = '';

    for (int i = 0; i < min(words.length, 2); i++) {
      if (!words[i].isEmptyOrNull()) {
        initials += words[i][0] ?? "";
        if (words.length < 2 && words[i].length > 1) {
          initials += words[i][1];
        }
      }
    }
    return initials.toUpperCase();
  }

  num? getOnlyNumberFromString() {
    return this.isEmptyOrNull()
        ? null
        : num.parse(this!.replaceAll(RegExp(r'[^0-9.]'), ''));
  }

  String removeEmoji() {
    final emojiRegExp = RegExp(
      r'[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{1F700}-\u{1F77F}\u{1F780}-\u{1F7FF}\u{1F800}-\u{1F8FF}\u{1F900}-\u{1F9FF}\u{1FA00}-\u{1FA6F}\u{1FA70}-\u{1FAFF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}\u{2300}-\u{23FF}\u{2B50}\u{1F004}-\u{1F0CF}\u{2B06}\u{2194}-\u{21AA}\u{2934}-\u{2935}\u{25AA}\u{25AB}\u{25FE}\u{25FD}\u{1F004}-\u{1F0CF}\u{2B50}\u{1F004}-\u{1F0CF}\u{1F004}-\u{1F0CF}\u{1F004}-\u{1F0CF}\u{2B50}\u{2934}-\u{2935}\u{25AA}\u{25AB}\u{25FE}\u{25FD}\u{1F004}-\u{1F0CF}\u{1F004}-\u{1F0CF}\u{1F004}-\u{1F0CF}\u{2B50}\u{2934}-\u{2935}\u{25AA}\u{25AB}\u{25FE}\u{25FD}\u{1F004}-\u{1F0CF}\u{1F004}-\u{1F0CF}\u{1F004}-\u{1F0CF}\u{2B50}\u{2934}-\u{2935}\u{25AA}\u{25AB}\u{25FE}\u{25FD}]',
      unicode: true,
    );
    return (this ?? "").replaceAll(emojiRegExp, '').trim();
  }

  String? capitalizeFirstLetter() {
    if (this.isEmptyOrNull()) return this;
    return this![0].toUpperCase() + this!.substring(1);
  }

  Color? colorFromHexString() => this != null
      ? Color(int.parse(this!.substring(1, 7), radix: 16) + 0xFF000000)
      : null;

  String getMaskedAccountNumber() {
    if (this == null) {
      return "";
    } else {
      return "XXXX${this!.substring(this!.length - (min(4, this!.length)))}";
    }
  }

  String getFirstName() {
    if (this == null) {
      return "";
    } else {
      var split = this!.split(" ");
      if (split.isNotEmpty) return split.first;
      return "";
    }
  }

  int levenshteinDistance(String s) {
    int len1 = this?.length ?? 0;
    int len2 = s.length ?? 0;

    // Create a 2D array to store the distances
    List<List<int>> dp =
        List.generate(len1 + 1, (_) => List.filled(len2 + 1, 0));

    // Initialize the base cases
    for (int i = 0; i <= len1; i++) {
      dp[i][0] = i;
    }
    for (int j = 0; j <= len2; j++) {
      dp[0][j] = j;
    }

    // Compute the distances
    for (int i = 1; i <= len1; i++) {
      for (int j = 1; j <= len2; j++) {
        int cost = this?[i - 1] == s[j - 1] ? 0 : 1;
        dp[i][j] = [
          dp[i - 1][j] + 1, // Deletion
          dp[i][j - 1] + 1, // Insertion
          dp[i - 1][j - 1] + cost // Substitution
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return dp[len1][len2];
  }
}

extension LabelTransform on String {
  String toLabelText() {
    List<String> components = this.split('/');

    List<String> transformedComponents = components.map((component) {
      List<String> words = component.split('_');
      List<String> capitalizedWords =
          words.map((word) => _capitalize(word)).toList();

      return capitalizedWords.join(' ');
    }).toList();

    return transformedComponents.join(' / ');
  }

  String _capitalize(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }
}

extension FileNameFromUrl on String {
  String getExtension(String type) {
    switch (type) {
      case 'image':
        final uri = Uri.parse(this);
        final segments = uri.pathSegments;
        if (segments.isNotEmpty) {
          final lastSegment = segments.last;
          final extension = lastSegment.split('.').last;
          if (extension == lastSegment) return "png";
          return extension;
        }
        return 'png';
      case 'video':
        return 'mp4';
      case 'lottie':
        return 'json';
      default:
        return 'bin';
    }
  }

  String getFileName() {
    try {
      final uri = Uri.parse(this);
      final segments = uri.pathSegments;
      if (segments.isNotEmpty) {
        final parts = segments.last.split(".");
        if (parts.isNotEmpty) return parts.first;
      }
    } catch (e) {
      logMessage(e.toString());
    }
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  String shortenFileName({int charCount = 40}) =>
      this.substring(this.length - min(charCount, this.length));
}
