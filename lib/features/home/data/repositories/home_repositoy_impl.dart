import 'dart:convert';

import 'package:chemical_compounds/core/constants/app_strings.dart';
import 'package:chemical_compounds/features/home/data/datasources/home_remote_data_source.dart';
import 'package:chemical_compounds/features/home/data/models/properties_model.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepository(this._remoteDataSource);

  Future<List<Property>> getItems({String cids = ''}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedJson = prefs.getString(AppStrings.cacheKey);

    List<Property> properties = <Property>[];

    if (cachedJson != null) {
      final List<dynamic> jsonList = jsonDecode(cachedJson);
      properties = jsonList.map((dynamic e) => Property.fromJson(e)).toList();
      // final Map<String, dynamic> jsonMap = jsonDecode(cachedJson);
      // properties = <Property>[Property.fromJson(jsonMap)];
    }

    if (cids.isNotEmpty) {
      Property? property = properties.firstWhereOrNull(
        (Property prop) => prop.cid.toString() == cids,
      );

      for (Property prop in properties) {
        if (prop.cid.toString() == cids) {
          property = prop;
          break;
        }
      }

      if (property == null) {
        final List<Property> fetched = await _remoteDataSource.fetchItems(
          cids: cids,
          properties: AppStrings.properties,
        );

        if (fetched.isEmpty) {
          throw Exception('No properties found for the given CID: $cids');
        }

        property = fetched.first;
        properties.insert(0, property);

        // Save updated list to cache
        properties = properties.length > 5
            ? properties.sublist(0, 5)
            : properties;
        final String jsonString = jsonEncode(
          properties.map((Property prop) => prop.toJson()).toList(),
        );
        await prefs.setString(AppStrings.cacheKey, jsonString);
      }
    }
    return properties;
  }

  Future<List<int>> getCID({required String compoundName}) async {
    return await _remoteDataSource.getCID(compoundName: compoundName);
  }

  Future<List<String>> searchCompound({required String query}) async {
    return await _remoteDataSource.searchCompound(query: query);
  }

  /// Cache the compound (in this example, using JSON encoding).
  Future<void> cacheCompound(
    String cid,
    Map<String, dynamic> compoundJson,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('compound_$cid', jsonEncode(compoundJson));
  }

  /// Retrieve a cached compound. Returns a map or null if not present.
  Future<Map<String, dynamic>?> getCachedCompound(String cid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('compound_$cid');
    if (jsonString != null) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }
}
