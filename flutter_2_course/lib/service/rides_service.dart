import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(RidePref preferences) {
    // print(availableRides);

    // For now, just a test
    return availableRides
        .where((ride) =>
            ride.departureLocation == preferences.departure &&
            ride.arrivalLocation == preferences.arrival)
        .toList();
  }
}

//
// Main for Testing the data to amount of data
//
void main() {
  // to see the amount of availables ride
  print("Ride Availables: ${RidesService.availableRides.length}");
  // Test the service
  RidesService.availableRides.forEach((rides) {
    print("Ride From ${rides.arrivalLocation} To ${rides.arrivalLocation}");
  });
}
