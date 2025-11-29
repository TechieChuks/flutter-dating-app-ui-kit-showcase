import 'package:datingapp/widgets/phone_input.dart';
import 'package:datingapp/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController _phoneController = TextEditingController();

  String _flag = "🇺🇸";
  String _dialCode = "(+1)";

  void _openCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            final countries = [
              {"flag": "🇺🇸", "name": "United States", "code": "(+1)"},
              {"flag": "🇬🇧", "name": "United Kingdom", "code": "(+44)"},
              {"flag": "🇳🇬", "name": "Nigeria", "code": "(+234)"},
              {"flag": "🇨🇦", "name": "Canada", "code": "(+1)"},
              {"flag": "🇰🇪", "name": "Kenya", "code": "(+254)"},
            ];

            return Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 70,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Select Country",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        return ListTile(
                          leading: Text(
                            country["flag"]!,
                            style: const TextStyle(fontSize: 26),
                          ),
                          title: Text(
                            country["name"]!,
                            style: const TextStyle(fontSize: 17),
                          ),
                          trailing: Text(
                            country["code"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _flag = country["flag"]!;
                              _dialCode = country["code"]!;
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _onContinue() {
    debugPrint("Phone Entered: ${_dialCode} ${_phoneController.text}");
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final height = media.size.height;
    final keyboardHeight = media.viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // important
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 22,
            right: 22,
            bottom: keyboardHeight + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.12),

              const Text(
                "My mobile",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 12),

              const Text(
                "Please enter your valid phone number. We will send you a 4-digit code to verify your account.",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: height * 0.06),

              PhoneInput(
                countryFlag: _flag,
                dialCode: _dialCode,
                controller: _phoneController,
                onTapCountry: _openCountryPicker,
              ),

              SizedBox(height: height * 0.08),

              PrimaryButton(
                label: "Continue",
                onPressed: _onContinue,
                height: 56,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
