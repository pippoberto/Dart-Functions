import 'dart:convert';
import 'dart:math';

/// Calculate the distance between two geographic positions.
double calculateDistance(LatLng userPosition, LatLng position) {
  const earthRadius = 6371; // in km

  final userPositionRadians = radians(userPosition.latitude);
  final positionRadians = radians(position.latitude);
  final latDiffRadians = radians(position.latitude - userPosition.latitude);
  final longDiffRadians = radians(position.longitude - userPosition.longitude);

  final a = sin(latDiffRadians / 2) * sin(latDiffRadians / 2) +
      cos(userPositionRadians) *
          cos(positionRadians) *
          sin(longDiffRadians / 2) *
          sin(longDiffRadians / 2);

  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final distance = earthRadius * c;

  return distance;
}
