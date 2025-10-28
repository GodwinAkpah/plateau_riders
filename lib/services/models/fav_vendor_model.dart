// To parse this JSON data, do
//
//     final FavVendorModel = categoryModelFromJson(jsonString);

import 'dart:convert';

FavVendorModel categoryModelFromJson(String str) =>
    FavVendorModel.fromJson(json.decode(str));

String categoryModelToJson(FavVendorModel data) => json.encode(data.toJson());

class FavVendorModel {
  final String status;
  final String message;
  final Data data;
  final DateTime timestamp;

  FavVendorModel({
    required this.status,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory FavVendorModel.fromJson(Map<String, dynamic> json) => FavVendorModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
    "timestamp": timestamp.toIso8601String(),
  };
}

class Data {
  final int currentPage;
  final List<FavVendorDatum> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<FavVendorDatum>.from(
      json["data"].map((x) => FavVendorDatum.fromJson(x)),
    ),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class FavVendorDatum {
  final int id;
  final String name;
  final dynamic avatar;
  final dynamic phone;
  final Location location;
  final DateTime favoritedAt;

  FavVendorDatum({
    required this.id,
    required this.name,
    required this.avatar,
    required this.phone,
    required this.location,
    required this.favoritedAt,
  });

  factory FavVendorDatum.fromJson(Map<String, dynamic> json) => FavVendorDatum(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    phone: json["phone"],
    location: Location.fromJson(json["location"]),
    favoritedAt: DateTime.parse(json["favorited_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "phone": phone,
    "location": location.toJson(),
    "favorited_at": favoritedAt.toIso8601String(),
  };
}

class Location {
  final int id;
  final String name;
  final String latitude;
  final String longitude;
  final String locationableType;
  final int locationableId;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.locationableType,
    required this.locationableId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    name: json["name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    locationableType: json["locationable_type"],
    locationableId: json["locationable_id"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "locationable_type": locationableType,
    "locationable_id": locationableId,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({required this.url, required this.label, required this.active});

  factory Link.fromJson(Map<String, dynamic> json) =>
      Link(url: json["url"], label: json["label"], active: json["active"]);

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
