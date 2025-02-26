import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A departure location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    departureDate = DateTime.now();
    requestedSeats = 1;

    // Initialize if there's an existing RidePref
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  //Switch Departure and Arrival Locations
  void _switchLocations() {
    if (departure != null && arrival != null) {
      setState(() {
        final temp = departure;
        departure = arrival;
        arrival = temp;
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  //Input Field Tile
  Widget inputFieldTile(IconData leadIcon, String label, IconData? trailIcon,
      VoidCallback onTapped) {
    return ListTile(
      leading: Icon(leadIcon),
      title: Text(
        label,
        style: BlaTextStyles.body,
      ),
      trailing: trailIcon != null
          ? IconButton(
              onPressed: _switchLocations,
              icon: Icon(trailIcon),
              color: BlaColors.primary,
            )
          : null,
      onTap: onTapped,
    );
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
          color: BlaColors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Depature Field
          inputFieldTile(
              Icons.radio_button_off,
              departure?.name ?? "Choose your Location",
              Icons.swap_vert,
              () {}),
          BlaDivider(),
          //Arrival Field
          inputFieldTile(
              Icons.radio_button_off,
              arrival != null
                  ? "${arrival!.name}, ${arrival!.country}"
                  : "Choose your Destination",
              null,
              () {}),
          BlaDivider(),
          //DepatureDate Field
          inputFieldTile(Icons.calendar_month,
              DateTimeUtils.formatDateTime(departureDate), null, () {}),
          BlaDivider(),
          //Requested Seats Field
          inputFieldTile(Icons.people, "$requestedSeats", null, () {}),
          //Booking Button
          BlaButton(
              type: BlaButtonType.primary,
              label: "Search",
              onPressedBlaButton: () {}),
        ],
      ),
    );
  }
}
