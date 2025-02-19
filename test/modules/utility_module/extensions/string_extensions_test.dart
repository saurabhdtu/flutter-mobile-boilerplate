import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utility_module/extensions/string_extensions.dart'; // Replace with the actual file name

void main() {
  group('NullStringUtils', () {
    test('isEmptyOrNull returns true for null', () {
      String? str = null;
      expect(str.isEmptyOrNull(), isTrue);
    });
    test('isEmptyOrNull returns true for empty string', () {
      String? str = "";
      expect(str.isEmptyOrNull(), isTrue);
    });

    test('isEmptyOrNull returns false for non-empty string', () {
      String? str = "hello";
      expect(str.isEmptyOrNull(), isFalse);
    });

    test('initials returns correct initials for single word', () {
      String? str = "John";
      expect(str.initials(), "JO");
    });

    test('initials returns correct initials for two words', () {
      String? str = "John Doe";
      expect(str.initials(), "JD");
    });

    test('initials returns correct initials for multiple words', () {
      String? str = "John David Doe";
      expect(str.initials(), "JD");
    });

    test('initials returns empty string for null', () {
      String? str = null;
      expect(str.initials(), "");
    });

    test('initials returns empty string for empty string', () {
      String? str = "";
      expect(str.initials(), "");
    });

    test('getOnlyNumberFromString returns correct number', () {
      String? str = "123abc456";
      expect(str.getOnlyNumberFromString(), 123456);
    });

    test('getOnlyNumberFromString returns null for null', () {
      String? str = null;
      expect(str.getOnlyNumberFromString(), null);
    });

    test('getOnlyNumberFromString returns null for empty string', () {
      String? str = "";
      expect(str.getOnlyNumberFromString(), null);
    });

    test('removeEmoji removes emojis from string', () {
      String? str = "Hello 😀 world! 👋";
      expect(str.removeEmoji(), "Hello  world!");
    });

    test('removeEmoji returns empty string for null', () {
      String? str = null;
      expect(str.removeEmoji(), "");
    });

    test('capitalizeFirstLetter capitalizes first letter', () {
      String? str = "hello";
      expect(str.capitalizeFirstLetter(), "Hello");
    });

    test('capitalizeFirstLetter returns null for null', () {
      String? str = null;
      expect(str.capitalizeFirstLetter(), str);
    });

    test('colorFromHexString returns correct color', () {
      String? str = "#FF0000";
      expect(str.colorFromHexString(), Color.fromARGB(255, 255, 0, 0));
    });

    test('colorFromHexString returns null for null', () {
      String? str = null;
      expect(str.colorFromHexString(), null);
    });

    test('getMaskedAccountNumber masks account number correctly', () {
      String? str = "1234567890";
      expect(str.getMaskedAccountNumber(), "XXXX7890");
    });

    test('getMaskedAccountNumber short account number correctly', () {
      String? str = "7890";
      expect(str.getMaskedAccountNumber(), "XXXX7890");
    });

    test('getMaskedAccountNumber short account number2 correctly', () {
      String? str = "90";
      expect(str.getMaskedAccountNumber(), "XXXX90");
    });

    test('getMaskedAccountNumber returns empty string for null', () {
      String? str = null;
      expect(str.getMaskedAccountNumber(), "");
    });

    test('getFirstName returns first name correctly', () {
      String? str = "John Doe";
      expect(str.getFirstName(), "John");
    });

    test('getFirstName returns empty string for null', () {
      String? str = null;
      expect(str.getFirstName(), "");
    });

    test('levenshteinDistance calculates distance correctly', () {
      String? str1 = "kitten";
      String str2 = "sitting";
      expect(str1.levenshteinDistance(str2), 3);
    });
  });

  group('FileNameFromUrl', () {
    test('getExtension returns correct extension for image', () {
      String url = "https://example.com/image.jpg";
      expect(url.getExtension('image'), "jpg");
    });

    test('getExtension returns default extension for image if not found', () {
      String url = "https://example.com/image";
      expect(url.getExtension('image'), "png");
    });

    test('getExtension returns correct extension for video', () {
      String url = "https://example.com/video.mp4";
      expect(url.getExtension('video'), "mp4");
    });

    test('getExtension returns correct extension for lottie', () {
      String url = "https://example.com/animation.json";
      expect(url.getExtension('lottie'), "json");
    });

    test('getExtension returns default extension for unknown type', () {
      String url = "https://example.com/file";
      expect(url.getExtension('unknown'), "bin");
    });

    test('getFileName returns correct file name', () {
      String url = "https://example.com/image.jpg";
      expect(url.getFileName(), "image");
    });

    test('getFileName returns timestamp for invalid url', () {
      String url = "invalid url";
      expect(url.getFileName(), isA<String>());
    });
    test('shortenFileName in case of file name<40', () {
      String url = "ABCDEFGHIJ";
      expect(url.shortenFileName(), "ABCDEFGHIJ");
    });
    test('shortenFileName in case of file name>=10', () {
      String url = "ABCDEFGHIJK";
      expect(url.shortenFileName(charCount: 10), "BCDEFGHIJK");
    });
  });
}
