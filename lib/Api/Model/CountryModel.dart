// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  final int count;
  final dynamic next;
  final dynamic previous;
  final Results results;

  CountryModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results.toJson(),
      };
}

class Results {
  final List<Country> countries;

  Results({
    required this.countries,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class Country {
  final int id;
  final String name;
  final String abbreviation;
  final String dialingCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  Country({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.dialingCode,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        abbreviation: json["abbreviation"],
        dialingCode: json["dialing_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "abbreviation": abbreviation,
        "dialing_code": dialingCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
