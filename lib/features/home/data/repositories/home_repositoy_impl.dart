import 'package:chemical_compounds/core/constants/app_strings.dart';
import 'package:chemical_compounds/features/home/data/datasources/home_remote_data_source.dart';
import 'package:chemical_compounds/features/home/data/models/properties_model.dart';

class HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepository(this._remoteDataSource);

  Future<List<Property>> getItems({required String cids}) async {
    return await _remoteDataSource.fetchItems(
      cids: cids,
      properties: AppStrings.properties,
    );
  }
}
