import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:zinc/constants/api_endpoints.dart';
import 'package:zinc/domain/app_data_source.dart';
import 'package:zinc/domain/bff/country_flag/country_model.dart';

class CountryFlagDataSource extends AppDataSource {
  CountryFlagDataSource._();

  static CountryFlagDataSource? _instance;

  static get getInstance => _instance ??= CountryFlagDataSource._();

  static CountriesResponse? _countriesResponse;

  Future<CountriesResponse> getCountriesList() async {
    late CountriesResponse countries;
    if (_countriesResponse != null) {
      countries = _countriesResponse!;
    } else {
      ZincAPIResponse<CountriesResponse> response = await makeRequest(
          ZincAPIRequest(
              requestType: RequestType.get,
              url: APIEndPoints.getCountries,
              mapper: CountriesResponse.fromJson));
      countries = response.body ?? CountriesResponse.error(response.error);
    }
    if (!countries.hasError) _countriesResponse = countries;
    return Future.value(countries);
  }

  Future<Country> getCountryDetails(
      {String? currency, String? name, String? iso2, String? iso3}) async {
    late CountriesResponse countries;
    if (_countriesResponse != null) {
      countries = _countriesResponse!;
    } else {
      ZincAPIResponse<CountriesResponse> response = await makeRequest(
          ZincAPIRequest(
              requestType: RequestType.get,
              url: APIEndPoints.getCountries,
              mapper: CountriesResponse.fromJson));
      countries = response.body ?? CountriesResponse.error(response.error);
    }
    if (!countries.hasError) _countriesResponse = countries;
    Country country = countries.countries.where((element) {
          return element.currency?.code?.toLowerCase() ==
                  currency?.toLowerCase() ||
              element.name?.toLowerCase() == name?.toLowerCase() ||
              element.isoAlpha2?.toLowerCase() == iso2?.toLowerCase() ||
              element.isoAlpha3?.toLowerCase() == iso3?.toLowerCase();
        }).firstOrNull ??
        Country();

    return Future.value(country.name == null
        ? Country.error(
            ZincAPIError(statusCode: 404, message: "Country does not exist"))
        : country);
  }
}
