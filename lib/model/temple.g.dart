part of 'temple.dart';

Temple _$TempleFromJson(Map<String, dynamic> json) => Temple(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      address: Map<String, String>.from(json['address'] as Map),
      province: Map<String, String>.from(json['province'] as Map),
      district: Map<String, String>.from(json['district'] as Map),
      subDistrict: Map<String, String>.from(json['subDistrict'] as Map),
      region: Map<String, String>.from(json['region'] as Map),
      geolocation: Temple._fromJsonGeoPoint(json['geolocation'] as GeoPoint),
      googleMapsPlaceId: json['googleMapsPlaceId'] as String,
      googleMapsPlusCode: json['googleMapsPlusCode'] as String,
    );

Map<String, dynamic> _$TempleToJson(Temple instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'province': instance.province,
      'district': instance.district,
      'subDistrict': instance.subDistrict,
      'region': instance.region,
      'googleMapsPlaceId': instance.googleMapsPlaceId,
      'googleMapsPlusCode': instance.googleMapsPlusCode,
      'geolocation': Temple._toJsonGeoPoint(instance.geolocation),
    };
