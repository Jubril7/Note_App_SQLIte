import 'package:flutter/material.dart';
import 'package:user_auth/Authentication/login.dart';
import 'package:user_auth/Models/users.dart';
import 'package:user_auth/SQLite/sqlite.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();


  final formKey = GlobalKey<FormState>();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ListTile(
                      title:  Text(
                      "Register new account",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red.withOpacity(.2)
                      ),
                      child: TextFormField(
                        controller: username,
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "username is required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          border: InputBorder.none,
                          hintText: "Username"
                        ),
                      ),
                    ), 
                
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red.withOpacity(.3)
                      ),
                      child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "password is required";
                          }
                          return null;
                        },
                        obscureText: isVisible,
                        decoration:  InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          }, 
                          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off)
                          )
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red.withOpacity(.3)
                      ),
                      child: TextFormField(
                        controller: confirmPassword,
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "password is required";
                          } else if(password.text != confirmPassword.text) {
                            return "Password don't match";
                          }
                          return null;
                        },
                        obscureText: isVisible,
                        decoration:  InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          }, 
                          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off)
                          )
                        ),
                      ),
                    ),
                
                    const SizedBox(height: 10,),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red
                      ),
                      child: TextButton(
                        onPressed: () {
                          if(formKey.currentState!.validate()) {
                            final  db = DatabaseHelper();

                            db
                              .signup(User(username: username.text, password: password.text))
                              .whenComplete(() {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                              });
                          }
                        }, 
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                          )
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        TextButton(onPressed: (){
                          Navigator.push(context, 
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen()
                            ));
                        }, 
                        child: const Text(
                          "Login", 
                          style: TextStyle(
                            color: Colors.red
                            ),
                          )
                        )
                      ],
                    )
                
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