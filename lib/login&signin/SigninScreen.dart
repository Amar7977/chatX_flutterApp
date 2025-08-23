import 'package:chatx/Widgets/uihelper.dart';
import 'package:chatx/login&signin/loginscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:glass_kit/glass_kit.dart';

class Signinscreen extends StatefulWidget {
  @override
  State<Signinscreen> createState() => _SigninscreenState();
}

class _SigninscreenState extends State<Signinscreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedLanguage;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFCFA1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFCFA1), Color(0xFFEEDCF5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        // Make the whole form scrollable
        child: Center(
          child: GlassContainer(
            width: 360,
            height: 710,
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.70),
                Colors.white.withOpacity(0.40),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderColor: Colors.white.withOpacity(0.2),
            blur: 15.0,
            elevation: 5.0,
            shadowColor: Colors.black.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),

                    UiHelper.CustomText(
                      text: "Sign Up",
                      height: 32,
                      color: Colors.black,
                      fontweight: FontWeight.bold,
                    ),
                    const SizedBox(height: 6),
                    UiHelper.CustomText(
                      text: "Create an account to continue!",
                      height: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(firstNameController, "First Name"),
                    const SizedBox(height: 12),

                    _buildTextField(lastNameController, "Last Name"),
                    const SizedBox(height: 12),

                    _buildTextField(
                      emailController,
                      "Enter Your Email",
                    ),
                    const SizedBox(height: 12),

                    // DOB Picker
                    TextField(
                      controller: dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "select date of birth",
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          dobController.text =
                              "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        }
                      },
                    ),

                    const SizedBox(height: 12),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedLanguage,
                        isExpanded: true,
                        icon: const SizedBox.shrink(), // hide default arrow
                        hint: Row(
                          children: const [
                            // yellow dot
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.yellow,
                            ),
                            SizedBox(width: 6),

                            // arrow
                            Icon(Icons.arrow_drop_down, color: Colors.black),
                            SizedBox(width: 10),

                            // vertical line separator
                            SizedBox(
                              height: 20,
                              child: VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            SizedBox(width: 10),

                            // placeholder text
                            Text(
                              "Language",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        items: ["English", "Hindi", "Marathi"]
                            .map(
                              (lang) => DropdownMenuItem(
                            value: lang,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.yellow,
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.arrow_drop_down, color: Colors.black),
                                const SizedBox(width: 10),
                                const SizedBox(
                                  height: 20,
                                  child: VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(lang),
                              ],
                            ),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    IntlPhoneField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      initialCountryCode: 'IN',
                      dropdownIconPosition: IconPosition.trailing, // arrow after +91
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        filled: true,
                        fillColor: Colors.white,
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey, width: 1.2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),


                    SizedBox(height: 12),

                    TextFormField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: '*******',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loginscreen()),
                            );
                          },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF1D61E7),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0XFF1D61E7),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to Login screen here
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => loginscreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
