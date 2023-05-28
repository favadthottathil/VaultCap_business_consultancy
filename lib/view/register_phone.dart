import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:taxverse/constants.dart';
import 'package:taxverse/controller/providers/auth_provider.dart';
import 'package:taxverse/utils/utils.dart';
import 'package:taxverse/view/frosted_glass.dart';

class RegisterWithPhone extends StatefulWidget {
  const RegisterWithPhone({super.key});

  @override
  State<RegisterWithPhone> createState() => _RegisterWithPhoneState();
}

class _RegisterWithPhoneState extends State<RegisterWithPhone> {
  final TextEditingController phoneController = TextEditingController();

  Country country = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  void registerWithPhoneNumber(AuthProvider provider) async {
    // final isValid = formkey.currentState!.validate();
    // if (!isValid) return;

    String phone = phoneController.text.trim();

    final msg = await provider.signInWithPhoneNumber('+${country.phoneCode}$phone', context);

    if (msg == '') return;

    // ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(msg),
    //   ),
    // );

    showSnackBar(context, msg);
  }

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneController.text.length),
    );
    final authprovider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Stack(
              children: [
                ListView(
                  children: [
                    const SizedBox(height: 150),
                    Container(
                      width: 200,
                      height: 200,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: blackColor.withOpacity(0.1),
                      ),
                      child: SvgPicture.asset('Asset/mobile.svg'),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Register",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Add your phone number, We'll send you a verification code",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      cursorColor: blackColor,
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          phoneController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter Phone Number',
                          hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black12),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  countryListTheme: CountryListThemeData(
                                    bottomSheetHeight: 550,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    searchTextStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  onSelect: (value) {
                                    setState(() {
                                      country = value;
                                    });
                                  },
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 2),
                                child: Text(
                                  "${country.flagEmoji} + ${country.phoneCode}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: phoneController.text.length > 9
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  margin: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: const Icon(
                                    Icons.done,
                                    color: whiteColor,
                                    size: 20,
                                  ),
                                )
                              : null),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        registerWithPhoneNumber(authprovider);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: blackColor,
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // if (authprovider.loading)
                //   const Center(
                //     child: FrostedGlass(
                //       width: double.infinity,
                //       height: double.infinity,
                //       child: Center(
                //         child: SpinKitCircle(
                //           color: blackColor,
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
