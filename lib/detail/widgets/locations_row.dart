import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:usability_projekt/library.dart';

class LocationsRow extends StatelessWidget {
  final List<Kopien> locations;

  const LocationsRow({
    required this.locations,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Standorte',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 20),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(width: 10),
                  Text(
                    locations[index].bibliothek ?? 'Kein Standort',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  locations[index].status == 'ausleihbar'
                      ? Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                        )
                      : Icon(
                          Ionicons.close_circle_outline,
                          color: Colors.red,
                        ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
