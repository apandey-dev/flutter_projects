import 'package:flutter/material.dart';

class SignupCard extends StatefulWidget {
  const SignupCard({super.key});

  @override
  State<SignupCard> createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  // Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        leading: const Icon(Icons.whatshot_sharp),
        title: const Text("Whatsapp Signup", style: TextStyle(fontSize: 23)),
        centerTitle: true,
      ),

      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFA5D6A7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: SingleChildScrollView(
            child: Center(
              child: Container(
                height: 600,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 90, left: 10, right: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 25),
                    // a26 8 256 1
                    // vivo t4x 6 128 1
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey, // Attach form key
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Full Name
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Full Name",
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Full name is required";
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 15),

                              // Mobile Number
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

                              // Email
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email is required";
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 15),

                              // Password
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
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

                              const SizedBox(height: 25),

                              // Signup Button
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
                                  if (_formKey.currentState!.validate()) {
                                    // If all fields valid
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Signup Successful"),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  "Signup",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Already have account
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Login",
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
      ),
    );
  }
}
