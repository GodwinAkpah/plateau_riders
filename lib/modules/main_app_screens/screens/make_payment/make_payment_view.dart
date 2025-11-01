import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/make_payment/make_payment_controller.dart';

class MakePaymentView extends GetView<MakePaymentController> {
  const MakePaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Make Payment', style: GoogleFonts.urbanist())),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... UI to match your screenshot with "Pay with Monnify" ...
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                onPressed: controller.isBooking.value ? null : controller.processPaymentAndBook,
                child: controller.isBooking.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Proceed'),
              )),
            ),
          ],
        ),
      ),
    );
  }
}