import 'package:equatable/equatable.dart';

class DescriptionModel extends Equatable {
  const DescriptionModel({required this.informationList});

  final InformationList? informationList;

  factory DescriptionModel.fromJson(Map<String, dynamic> json) {
    return DescriptionModel(
      informationList: json["InformationList"] == null
          ? null
          : InformationList.fromJson(json["InformationList"]),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "InformationList": informationList?.toJson(),
  };

  @override
  List<Object?> get props => <Object?>[informationList];
}

class InformationList extends Equatable {
  const InformationList({required this.listOfDescription});

  final List<Description> listOfDescription;

  factory InformationList.fromJson(Map<String, dynamic> json) {
    return InformationList(
      listOfDescription: json["Information"] == null
          ? <Description>[]
          : List<Description>.from(
              json["Information"]!.map((dynamic x) => Description.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "Information": listOfDescription
        .map((Description x) => x.toJson())
        .toList(),
  };

  @override
  List<Object?> get props => <Object?>[listOfDescription];
}

class Description extends Equatable {
  const Description({
    required this.cid,
    required this.title,
    required this.description,
    required this.descriptionSourceName,
    required this.descriptionUrl,
  });

  final int? cid;
  final String? title;
  final String? description;
  final String? descriptionSourceName;
  final String? descriptionUrl;

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      cid: json["CID"],
      title: json["Title"],
      description: json["Description"],
      descriptionSourceName: json["DescriptionSourceName"],
      descriptionUrl: json["DescriptionURL"],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "CID": cid,
    "Title": title,
    "Description": description,
    "DescriptionSourceName": descriptionSourceName,
    "DescriptionURL": descriptionUrl,
  };

  @override
  List<Object?> get props => <Object?>[
    cid,
    title,
    description,
    descriptionSourceName,
    descriptionUrl,
  ];
}
