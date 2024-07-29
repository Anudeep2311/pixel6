class CustomerModel {
  String pan;
  String fullName;
  String email;
  String phoneNumber;
  List<Address> addresses;

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

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      pan: json['pan'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      addresses: (json['addresses'] as List)
          .map((item) => Address.fromJson(item))
          .toList(),
    );
  }
}

class Address {
  String addressLineOne;
  String addressLineTwo;
  String postcode;
  String state;
  String city;

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

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLineOne: json['addressLineOne'],
      addressLineTwo: json['addressLineTwo'],
      postcode: json['postcode'],
      state: json['state'],
      city: json['city'],
    );
  }
}
