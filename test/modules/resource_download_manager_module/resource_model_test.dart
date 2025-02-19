import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:resource_download_manager_module/resource_model.dart';

void main() {
  group('ResourceItem JSON Parsing and File Name Generation', () {
    test('ResourceItem generates file_name from url if file_name is empty', () {
      // Given JSON data with empty file_name
      const jsonString = '''
      [
        {
          "file_type": "image",
          "file_name": "",
          "url": "https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/airwallex/onboarding-test-1.png"
        },
        {
          "file_type": "lottie",
          "file_name": "",
          "url": "https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/airwallex/landing.json"
        }
      ]
      ''';

      // Parse JSON string to list
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final List<ResourceItem> resourceItems = jsonList.map((json) => ResourceItem.fromJson(json)).toList();

      // Act & Assert: Check if the file_name was generated correctly from the url
      expect(resourceItems[0].fileName, 'onboarding-test-1.png');
      expect(resourceItems[1].fileName, 'landing.json');
    });

    test('ResourceItem uses provided file_name if not empty', () {
      // Given JSON data with non-empty file_name
      const jsonString = '''
      [
        {
          "file_type": "image",
          "file_name": "custom_image_name.png",
          "url": "https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/airwallex/onboarding-test-1.png"
        },
        {
          "file_type": "video",
          "file_name": "custom_video_name.mp4",
          "url": "https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/video.mp4"
        }
      ]
      ''';

      // Parse JSON string to list
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final List<ResourceItem> resourceItems = jsonList.map((json) => ResourceItem.fromJson(json)).toList();

      // Act & Assert: Check if the provided file_name is used
      expect(resourceItems[0].fileName, 'custom_image_name.png');
      expect(resourceItems[1].fileName, 'custom_video_name.mp4');
    });

    test('ResourceItem toJson works correctly', () {
      // Given a ResourceItem instance
      final resourceItem = ResourceItem(
        fileType: 'image',
        url: 'https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/airwallex/onboarding-test-1.png',
      );

      // Act: Convert the ResourceItem to JSON
      final json = resourceItem.toJson();

      // Assert: Verify the JSON output
      expect(json['file_type'], 'image');
      expect(json['url'], 'https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/airwallex/onboarding-test-1.png');
      expect(json['file_name'], 'onboarding-test-1.png');  // file_name generated from URL
    });

    test('ResourceItem fromJson works correctly', () {
      // Given JSON data
      const json = {
        'file_type': 'image',
        'file_name': '',
        'url': 'https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/airwallex/onboarding-test-1.png',
      };

      // Act: Create a ResourceItem from JSON
      final resourceItem = ResourceItem.fromJson(json);

      // Assert: Verify the values are correctly initialized
      expect(resourceItem.fileType, 'image');
      expect(resourceItem.url, 'https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/airwallex/onboarding-test-1.png');
      expect(resourceItem.fileName, 'onboarding-test-1.png');  // file_name generated from URL
    });

    test('ResourceItem handles multiple types correctly', () {
      // Given JSON data with multiple file types
      const jsonString = '''
      [
        {
          "file_type": "image",
          "file_name": "",
          "url": "https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/airwallex/onboarding-test-1.png"
        },
        {
          "file_type": "video",
          "file_name": "",
          "url": "https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/airwallex/video.mp4"
        },
        {
          "file_type": "lottie",
          "file_name": "",
          "url": "https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/airwallex/landing.json"
        }
      ]
      ''';

      // Parse JSON string to list
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final List<ResourceItem> resourceItems = jsonList.map((json) => ResourceItem.fromJson(json)).toList();

      // Act & Assert: Check if the file_name is generated correctly for each type
      expect(resourceItems[0].fileName, 'onboarding-test-1.png');  // Image
      expect(resourceItems[1].fileName, 'video.mp4');  // Video
      expect(resourceItems[2].fileName, 'landing.json');  // Lottie/JSON
    });
  });
}
