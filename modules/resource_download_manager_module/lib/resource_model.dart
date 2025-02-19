import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:network_module/data/responses/responses.dart';
import 'package:resource_download_manager_module/file_operations.dart';
import 'package:utility_module/extensions/string_extensions.dart';

class ResourceListResponse extends BaseResponse {
  ResourceListResponse.error(err) : super.error(err);
  List<ResourceItem>? resourceItem;

  ResourceListResponse({this.resourceItem});

  ResourceListResponse.fromJson(dynamic json) {
    if (json['asset_list'] != null) {
      resourceItem = <ResourceItem>[];
      json['asset_list'].forEach((v) {
        resourceItem!.add(new ResourceItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceItem != null) {
      data['asset_list'] = this.resourceItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvatarListResponse {
  List<ResourceItem>? avatars;

  AvatarListResponse({this.avatars});

  AvatarListResponse.fromJson(dynamic json) {
    if (json['avatar_list'] != null) {
      avatars = <ResourceItem>[];
      json['avatar_list'].forEach((v) {
        avatars!.add(new ResourceItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.avatars != null) {
      data['avatar_list'] = this.avatars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResourceItem {
  final String fileType;
  final String url;
  String fileName;
  String? filePath;
  bool fileExists = false;

  ResourceItem({required this.fileType, required this.url, String? fileName})
      : fileName = fileName != null && fileName.isNotEmpty ? fileName : _generateFileName(url, fileType) {
    if (kDebugMode) {
      print('Resource created: $fileType, $url, $fileName');
    }
    // _setFilePath();
  }

  Future<void> setFilePath() async {
    final directoryPath = await FileOperations.getApplicationDirectoryPath();
    final fPath = '$directoryPath/$fileName';
    filePath = fPath;
    fileExists = File(filePath ?? "").existsSync();
  }

  static String _generateFileName(String url, String type) {
    return '${url.getFileName()}.${url.getExtension(type)}';
  }

  factory ResourceItem.fromMap(Map<String, String> map) {
    return ResourceItem(
      fileType: map['file_type']!,
      url: map['url']!,
    );
  }

  Map<String, String> toMap() {
    return {
      'file_type': fileType,
      'url': url,
      'fileName': fileName,
    };
  }

  factory ResourceItem.fromJson(Map<String, dynamic> json) {
    return ResourceItem(
      fileType: json['file_type']!,
      fileName: json['file_name']!,
      url: json['url']!,
    );
  }

  Map<String, dynamic> toJson() {
    // If fileName is empty or null, regenerate it
    if (fileName.isEmpty) {
      fileName = _generateFileName(url, fileType);
    }
    return {
      'file_type': fileType,
      'file_name': fileName,
      'url': url,
    };
  }
}
