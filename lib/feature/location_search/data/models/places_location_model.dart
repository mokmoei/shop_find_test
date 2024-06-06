import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
  const PlaceModel({
    required this.formattedAddress,
    required this.displayName,
    required this.location,
  });

  final String formattedAddress;
  final DisplayName displayName;
  final PlaceLocation location;

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      formattedAddress: json["formattedAddress"],
      displayName:
          DisplayName.fromJson(json["displayName"] as Map<String, dynamic>),
      location:
          PlaceLocation.fromJson(json["location"] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [
        formattedAddress,
        displayName,
        location,
      ];
}

class DisplayName extends Equatable {
  const DisplayName({
    required this.text,
  });

  final String text;

  factory DisplayName.fromJson(Map<String, dynamic> json) {
    return DisplayName(
      text: json["text"],
    );
  }

  @override
  List<Object?> get props => [text];
}

class PlaceLocation extends Equatable {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return PlaceLocation(
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  @override
  List<Object?> get props => [latitude, longitude];
}
