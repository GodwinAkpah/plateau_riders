import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateau_riders/modules/app_colors/plateau_colors.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/passenger_details/passenger_details_controller.dart';
import 'package:plateau_riders/services/models/passenger_info_model.dart';

class PassengerDetailsView extends GetView<PassengerDetailsController> {
  const PassengerDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              // Use the selectedSeats list to show the current seat number
              'Details for Seat ${controller.selectedSeats[controller.currentPage.value]}',
              style: GoogleFonts.urbanist(fontWeight: FontWeight.bold),
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.numberOfSeats, // Now this exists
              itemBuilder: (context, index) {
                return _buildPassengerForm(controller.passengerForms[index]);
              },
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildPassengerForm(PassengerInfo passenger) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: passenger.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
                controller: passenger.nameController,
                label: 'Full Name', hint: 'Enter passenger\'s full name'),
            _buildTextField(
                controller: passenger.emailController,
                label: 'Email Address', hint: 'Enter email address',
                keyboardType: TextInputType.emailAddress),
            _buildTextField(
                controller: passenger.phoneController,
                label: 'Phone Number', hint: 'Enter phone number',
                keyboardType: TextInputType.phone),
            _buildGenderDropdown(passenger),
            const SizedBox(height: 24),
            Text('Next of Kin Details', style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w600)),
            const Divider(),
            _buildTextField(
                controller: passenger.nokNameController,
                label: 'Full Name (Next of Kin)', hint: 'Enter next of kin\'s full name'),
            _buildTextField(
                controller: passenger.nokPhoneController,
                label: 'Phone Number (Next of Kin)', hint: 'Enter next of kin\'s phone number',
                keyboardType: TextInputType.phone),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label, hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) => (value == null || value.isEmpty) ? '$label is required' : null,
      ),
    );
  }

  Widget _buildGenderDropdown(PassengerInfo passenger) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: passenger.selectedGender,
        decoration: InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        hint: const Text('Select Gender'),
        items: ['male', 'female']
            .map((gender) => DropdownMenuItem(value: gender, child: Text(gender.capitalizeFirst!)))
            .toList(),
        onChanged: (value) => passenger.selectedGender = value,
        validator: (value) => value == null ? 'Gender is required' : null,
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() {
        // --- ALL FIXES APPLIED HERE ---
        final isLastPage = controller.currentPage.value == controller.numberOfSeats - 1;
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.isBooking.value // Check the new 'isBooking' property
                ? null
                : (isLastPage ? controller.proceedToConfirmation : controller.nextPage), // Call the renamed method
            style: ElevatedButton.styleFrom(
              backgroundColor: PlateauColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: controller.isBooking.value // Use '.value' here
                ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white))
                : Text(
                    isLastPage ? 'Proceed to Confirmation' : 'Next Passenger',
                    style: GoogleFonts.urbanist(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
        );
      }),
    );
  }
}