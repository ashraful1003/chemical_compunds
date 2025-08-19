class API {
  static String details({
    required String compoundName,
    required String properties,
  }) => '/name/$compoundName/property/$properties/JSON';

  static String synonyms({required String compoundName}) =>
      '/name/$compoundName/synonyms/JSON';

  static String description({required String compoundName}) =>
      '/name/$compoundName/description/JSON';

  static String image({required int cid}) => '/cid/$cid/PNG';
}
