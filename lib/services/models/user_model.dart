class UserModel {
  final int id;
  final String? avatar; // This might be a full URL or a relative path
  final String fname;
  final String lname;
  final String phone;
  final String email;

  // --- THIS IS THE FINAL, ROBUST GETTER ---
  String? get fullAvatarUrl {
    // 1. If avatar is null, there's no URL to build.
    if (avatar == null) return null;

    // 2. Check if the avatar string from the API already contains "http".
    //    If it does, it's already a full URL and we can use it directly.
    if (avatar!.startsWith('http')) {
      return avatar;
    }

    // 3. If it does NOT contain "http", it's a relative path.
    //    We will safely build the full URL.
    try {
      return Uri(
        scheme: 'https',
        host: 'esemunch.gnorizon.com',
        path: avatar,
      ).toString();
    } catch (e) {
      print("Error creating avatar URL from relative path: $e");
      return null;
    }
  }
  // ------------------------------------------

  UserModel({
    required this.id,
    this.avatar,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.email,
  });

  String get fullName => '$fname $lname';

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final userData = map.containsKey('user') ? map['user'] as Map<String, dynamic> : map;
    return UserModel(
      id: userData['id'] ?? 0,
      avatar: userData['avatar'],
      fname: userData['fname'] ?? '',
      lname: userData['lname'] ?? '',
      phone: userData['phone'] ?? '',
      email: userData['email'] ?? '',
    );
  }
}