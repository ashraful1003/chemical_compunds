import 'package:equatable/equatable.dart';

class SearchResultModel extends Equatable {
  const SearchResultModel({required this.identifierList});

  final IdentifierList? identifierList;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      identifierList: json["IdentifierList"] == null
          ? null
          : IdentifierList.fromJson(json["IdentifierList"]),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "IdentifierList": identifierList?.toJson(),
  };

  @override
  List<Object?> get props => <Object?>[identifierList];
}

class IdentifierList extends Equatable {
  const IdentifierList({required this.cid});

  final List<int> cid;

  factory IdentifierList.fromJson(Map<String, dynamic> json) {
    return IdentifierList(
      cid: json["CID"] == null
          ? <int>[]
          : List<int>.from(json["CID"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "CID": cid.map((int x) => x).toList(),
  };

  @override
  List<Object?> get props => <Object?>[cid];
}
