import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/whatsapp_ui/signup_card.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  // Global key to manage form state
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        // Full screen light green gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFA5D6A7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        // Outer scroll view (prevents overflow when keyboard opens)
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: 600,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 90, left: 10, right: 10),
              padding: const EdgeInsets.all(15),

              // Card styling
              decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                children: [
                  const SizedBox(height: 18),

                  // Title
                  Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.fredoka(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Expanded makes form area flexible
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey, // Attach form key here
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Mobile Field
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Mobile Number",
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(Icons.call),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.number,

                              // Validation logic
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Mobile number required";
                                }
                                if (value.length != 10) {
                                  return "Enter valid 10 digit number";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 15),

                            // Email Field
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Email",
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,

                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !value.contains("@")) {
                                  return "Email required";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 15),

                            // Password Field
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Enter Password",
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password required";
                                }
                                if (value.length < 6) {
                                  return "Minimum 6 characters";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            // Login Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Validate all fields
                                if (_formKey.currentState!.validate()) {
                                  // If valid
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Login Successful"),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(height: 15),

                            // Forgot Password
                            TextButton(
                              onPressed: () {
                                // Forgot password logic here
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Signup Navigation Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "New to Whatsapp?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupCard(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Signup",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
