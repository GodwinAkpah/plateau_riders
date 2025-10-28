import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectCityBottomSheet extends StatelessWidget {
  const SelectCityBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select City',
            style: GoogleFonts.urbanist(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildCityItem(context, 'F.C.T, Abuja'),
          _buildCityItem(context, 'Plateau, Jos'),
          // Add more cities here
        ],
      ),
    );
  }

  Widget _buildCityItem(BuildContext context, String city) {
    return ListTile(
      title: Text(city, style: GoogleFonts.urbanist()),
      onTap: () {
        Navigator.of(context).pop(city);
      },
    );
  }
}
