// Utility to convert country abbreviations to full names

class CountriesFullNameConverter {
  String convertToFullName(String countryName) {
    switch (countryName) {
      case 'USA':
        return 'United States';
        break;
      case 'UK':
        return 'United Kingdom';
        break;
      case 'UAE':
        return 'United Arab Emirates';
        break;
      default:
        return countryName;
    }
  }
}