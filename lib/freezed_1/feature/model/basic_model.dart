class BasicModel {
  final String name;
  final String country;

  BasicModel({required this.name, required this.country})
      : assert(name.length > 1);

  @override
  String toString() {
    return 'BasicModel(name: $name, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BasicModel &&
        other.name == name &&
        other.country == country;
  }

  @override
  int get hashCode => name.hashCode ^ country.hashCode;

  // JSON 직렬화 (객체 -> JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
    };
  }

  // JSON 역직렬화 (JSON -> 객체)
  factory BasicModel.fromJson(Map<String, dynamic> json) {
    return BasicModel(
      name: json['name'] as String,
      country: json['country'] as String,
    );
  }
}
