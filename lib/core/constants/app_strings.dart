class AppStrings {
  static final AppStrings _instance = AppStrings._internal();

  factory AppStrings() {
    return _instance;
  }

  AppStrings._internal();

  static const String properties = 'MolecularFormula,MolecularWeight,IUPACName';
  static const String cid = "cid";
  static const String iupacName = "iupacName";
  static const String cacheKey = "cached_compound";
}
