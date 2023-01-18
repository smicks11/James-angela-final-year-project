class CityNewsModel {
  final String cityNews;
  final String user;
  final String cityName;
  final DateTime time;

  CityNewsModel(
      {required this.cityNews,
      required this.user,
      required this.cityName,
      required this.time});
}

class City {
  final String city;
  final String id;

  City({required this.city, required this.id});
}

List<City> cityData = [
  City(city: "Ifaki", id: "IT5wLgbfFbkijt9XB09b"),
  City(city: "Aiyegbaju", id: "LNfM5ajojHCUgrNHz0Sx"),
  City(city: "Oye", id: "smwKAzGThMuoT5IHNTWq"),
  City(city: "Ikole", id: "v76eFlsmpqS4RISv2H9z")
];
