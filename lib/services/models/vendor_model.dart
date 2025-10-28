class VendorModel {
  final int id;
  final String? avatar;
  final String fname;
  final String lname;
  final String? phone;
  final String? phoneVerifiedAt;
  final String email;
  final DateTime? emailVerifiedAt;
  final String? verifiedAt;
  final String? referralCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> favorites;
  final VendorLocation? location;
  final List<Product> products;
  final List<VendorSchedule> vendorSchedules;
  VendorModel({
    required this.id,
    required this.avatar,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.phoneVerifiedAt,
    required this.email,
    required this.emailVerifiedAt,
    required this.verifiedAt,
    required this.referralCode,
    required this.createdAt,
    required this.updatedAt,
    required this.favorites,
    required this.location,
    required this.products,
    required this.vendorSchedules,
  });

  /// Creates a new VendorModel instance with updated values.
  VendorModel copyWith({
    int? id,
    dynamic avatar,
    String? fname,
    String? lname,
    dynamic phone,
    dynamic phoneVerifiedAt,
    String? email,
    DateTime? emailVerifiedAt,
    dynamic verifiedAt,
    dynamic referralCode,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic>? favorites,
    VendorLocation? location,
    List<Product>? products,
    List<VendorSchedule>? vendorSchedules,
  }) {
    return VendorModel(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      phone: phone ?? this.phone,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      referralCode: referralCode ?? this.referralCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      favorites: favorites ?? this.favorites,
      location: location ?? this.location,
      products: products ?? this.products,
      vendorSchedules: vendorSchedules ?? this.vendorSchedules,
    );
  }

  String get fullName => '$fname $lname';

  String? get fullAvatarUrl {
    if (avatar == null) return null;
    return "https://esemunch.gnorizon.com" + avatar!;
  }

  String get category =>
      products.isNotEmpty ? products.first.name : "No category";
  bool get isFavorited => favorites.isNotEmpty;

  // --- THIS IS THE FINAL, CORRECTED FACTORY ---
  factory VendorModel.fromMap(Map<String, dynamic> map) {
    String finalFname = '';
    String finalLname = '';

    // Check if the map uses 'fname' and 'lname' (from the main vendor endpoint)
    if (map.containsKey('fname')) {
      finalFname = map['fname'] ?? '';
      finalLname = map['lname'] ?? '';
    }
    // ELSE, check if it uses a single 'name' field (from the favorites endpoint)
    else if (map.containsKey('name') && map['name'] != null) {
      String fullName = map['name'];
      // Split the full name into parts by the first space
      final nameParts = fullName.split(' ');
      finalFname = nameParts.isNotEmpty ? nameParts.first : '';
      // Join the rest of the parts back together in case of middle names
      finalLname = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    }

    return VendorModel(
      id: map['id'] ?? 0,
      avatar: map['avatar'] ?? '',
      fname: finalFname, // Use the intelligently parsed first name
      lname: finalLname, // Use the intelligently parsed last name
      phone: map['phone'] ?? '',
      phoneVerifiedAt: map["phone_verified_at"],
      email: map['email'] ?? '',
      emailVerifiedAt:
          map["email_verified_at"] != null
              ? DateTime.parse(map["email_verified_at"])
              : null,
      verifiedAt: map["verified_at"],
      referralCode: map["referral_code"],
      createdAt: DateTime.parse(map["created_at"]),
      updatedAt: DateTime.parse(map["updated_at"]),
      location:
          map['location'] == null
              ? null
              : VendorLocation.fromMap(map['location']),

      // The favorites endpoint doesn't send products, so this check is good
      products:
          map['products'] != null
              ? List<Product>.from(
                map['products'].map((x) => Product.fromMap(x)),
              )
              : [],

      // Safely check for schedules, as the favorites endpoint does not provide this
      vendorSchedules:
          map.containsKey('vendor_schedules') && map['vendor_schedules'] != null
              ? List<VendorSchedule>.from(
                map['vendor_schedules'].map((x) => VendorSchedule.fromMap(x)),
              )
              : [],

      favorites: map['favorites'] ?? [],
    );
  }
}

class VendorSchedule {
  final int id;
  final String dayOfWeek;
  final String openingTime;
  final String closingTime;

  VendorSchedule({
    required this.id,
    required this.dayOfWeek,
    required this.openingTime,
    required this.closingTime,
  });

  factory VendorSchedule.fromMap(Map<String, dynamic> map) {
    return VendorSchedule(
      id: map['id'] ?? 0,
      dayOfWeek: map['day_of_week'] ?? '',
      openingTime: map['opening_time'] ?? 'N/A',
      closingTime: map['closing_time'] ?? 'N/A',
    );
  }
}

class VendorLocation {
  final int id;
  final String latitude;
  final String longitude;
  final String deletedAt;

  VendorLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.deletedAt,
  });

  factory VendorLocation.fromMap(Map<String, dynamic> map) {
    return VendorLocation(
      id: map['id'] ?? 0,
      latitude: map['latitude'] ?? '0.0',
      longitude: map['longitude'] ?? '0.0',
      deletedAt: map["deleted_at"] ?? '',
    );
  }
}

class Product {
  final int id;
  final String name;
  final String price;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      price: map['price'] ?? '0.00',
      description: map['description'] ?? 'No description available.',
    );
  }
}
