import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _prevImageUrl;
  //i will not implement map cause i am broke(didn't have credit card)
  Future<void> getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _prevImageUrl == null
              ? Text(
                  'No Location choosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _prevImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}
