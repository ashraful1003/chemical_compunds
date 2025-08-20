import 'package:equatable/equatable.dart';

class SearchResultModel extends Equatable {
  SearchResultModel({required this.identifierList});

  final IdentifierList? identifierList;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      identifierList: json["IdentifierList"] == null
          ? null
          : IdentifierList.fromJson(json["IdentifierList"]),
    );
  }

  Map<String, dynamic> toJson() => {"IdentifierList": identifierList?.toJson()};

  @override
  List<Object?> get props => [identifierList];
}

class IdentifierList extends Equatable {
  IdentifierList({required this.cid});

  final List<int> cid;

  factory IdentifierList.fromJson(Map<String, dynamic> json) {
    return IdentifierList(
      cid: json["CID"] == null
          ? []
          : List<int>.from(json["CID"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {"CID": cid.map((x) => x).toList()};

  @override
  List<Object?> get props => [cid];
}
