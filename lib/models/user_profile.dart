import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfile {
  final String id;
  String name;
  String email;
  String phone;
  String avatar;
  final String joinedDate;
  final double rating;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.joinedDate,
    this.rating = 5.0,
  });

  /// Returns the right ImageProvider whether [avatar] is a remote URL
  /// (default mock data) or a local file path (after the user picks a
  /// photo from their gallery in Edit Profile).
  ImageProvider avatarImageProvider() {
    if (avatar.startsWith('http')) {
      return CachedNetworkImageProvider(avatar);
    }
    return FileImage(File(avatar));
  }
}
