class CustomerModel {
  final String pan;
  final String fullName;
  final String email;
  final String phoneNumber;
  final List<Address> addresses;

  CustomerModel({
    required this.pan,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.addresses,
  });

  Map<String, dynamic> toJson() => {
        'pan': pan,
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'addresses': addresses.map((e) => e.toJson()).toList(),
      };

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        pan: json['pan'],
        fullName: json['fullName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        addresses: (json['addresses'] as List<dynamic>)
            .map((e) => Address.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class Address {
  final String addressLineOne;
  final String addressLineTwo;
  final String postcode;
  final String state;
  final String city;

  Address({
    required this.addressLineOne,
    required this.addressLineTwo,
    required this.postcode,
    required this.state,
    required this.city,
  });

  Map<String, dynamic> toJson() => {
        'addressLineOne': addressLineOne,
        'addressLineTwo': addressLineTwo,
        'postcode': postcode,
        'state': state,
        'city': city,
      };

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLineOne: json['addressLineOne'],
        addressLineTwo: json['addressLineTwo'],
        postcode: json['postcode'],
        state: json['state'],
        city: json['city'],
      );
}
