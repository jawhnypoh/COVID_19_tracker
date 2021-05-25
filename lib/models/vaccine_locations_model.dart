// VaccineLocations Class for Individual Vaccine Location Info

class VaccineLocation {
  String type;
  Geometry geometry;
  Properties properties;

  VaccineLocation({this.type, this.geometry, this.properties});

  VaccineLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    return data;
  }
}

class Geometry {
  String type;
  List<double> coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Properties {
  int id;
  String url;
  String city;
  String name;
  String state;
  String address;
  String provider;
  String timeZone;
  String postalCode;
  String providerBrand;
  bool carriesVaccine;
  AppointmentTypes appointmentTypes;
  int providerBrandId;
  String providerBrandName;
  String providerLocationId;
  bool appointmentsAvailable;
  AppointmentTypes appointmentVaccineTypes;
  String appointmentsLastFetched;
  String appointmentsLastModified;
  bool appointmentsAvailableAllDoses;
  bool appointmentsAvailable2ndDoseOnly;

  Properties(
      {this.id,
        this.url,
        this.city,
        this.name,
        this.state,
        this.address,
        this.provider,
        this.timeZone,
        this.postalCode,
        this.providerBrand,
        this.carriesVaccine,
        this.appointmentTypes,
        this.providerBrandId,
        this.providerBrandName,
        this.providerLocationId,
        this.appointmentsAvailable,
        this.appointmentVaccineTypes,
        this.appointmentsLastFetched,
        this.appointmentsLastModified,
        this.appointmentsAvailableAllDoses,
        this.appointmentsAvailable2ndDoseOnly});

  Properties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    city = json['city'];
    name = json['name'];
    state = json['state'];
    address = json['address'];
    provider = json['provider'];
    timeZone = json['time_zone'];
    postalCode = json['postal_code'];
    providerBrand = json['provider_brand'];
    carriesVaccine = json['carries_vaccine'];
    appointmentTypes = json['appointment_types'] != null
        ? new AppointmentTypes.fromJson(json['appointment_types'])
        : null;
    providerBrandId = json['provider_brand_id'];
    providerBrandName = json['provider_brand_name'];
    providerLocationId = json['provider_location_id'];
    appointmentsAvailable = json['appointments_available'];
    appointmentVaccineTypes = json['appointment_vaccine_types'] != null
        ? new AppointmentTypes.fromJson(json['appointment_vaccine_types'])
        : null;
    appointmentsLastFetched = json['appointments_last_fetched'];
    appointmentsLastModified = json['appointments_last_modified'];
    appointmentsAvailableAllDoses = json['appointments_available_all_doses'];
    appointmentsAvailable2ndDoseOnly =
    json['appointments_available_2nd_dose_only'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['city'] = this.city;
    data['name'] = this.name;
    data['state'] = this.state;
    data['address'] = this.address;
    data['provider'] = this.provider;
    data['time_zone'] = this.timeZone;
    data['postal_code'] = this.postalCode;
    data['provider_brand'] = this.providerBrand;
    data['carries_vaccine'] = this.carriesVaccine;
    if (this.appointmentTypes != null) {
      data['appointment_types'] = this.appointmentTypes.toJson();
    }
    data['provider_brand_id'] = this.providerBrandId;
    data['provider_brand_name'] = this.providerBrandName;
    data['provider_location_id'] = this.providerLocationId;
    data['appointments_available'] = this.appointmentsAvailable;
    if (this.appointmentVaccineTypes != null) {
      data['appointment_vaccine_types'] = this.appointmentVaccineTypes.toJson();
    }
    data['appointments_last_fetched'] = this.appointmentsLastFetched;
    data['appointments_last_modified'] = this.appointmentsLastModified;
    data['appointments_available_all_doses'] =
        this.appointmentsAvailableAllDoses;
    data['appointments_available_2nd_dose_only'] =
        this.appointmentsAvailable2ndDoseOnly;
    return data;
  }
}

class AppointmentTypes {
  bool unknown;

  AppointmentTypes({this.unknown});

  AppointmentTypes.fromJson(Map<String, dynamic> json) {
    unknown = json['unknown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unknown'] = this.unknown;
    return data;
  }
}