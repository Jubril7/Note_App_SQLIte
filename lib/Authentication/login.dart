import 'package:flutter/material.dart';
import 'package:user_auth/Authentication/signup.dart';
import 'package:user_auth/Models/users.dart';
import 'package:user_auth/SQLite/sqlite.dart';
import 'package:user_auth/Views/notes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool isVisible = false;

bool isLoginTrue = false;

login() async{
  var response = await db.login(User(username: username.text, password: password.text));
  if(response == true) {
    if(!mounted)return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Notes()));
  } else {
    setState(() {
      isLoginTrue = true;
    });
  }
}

  final db = DatabaseHelper();
  
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
              
                  Image.asset(
                    "lib/assets/Arsenal_Badge.png",
                    width: 150.0,
                    ),
              
                  const SizedBox(height: 15),
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
              
                  const SizedBox(height: 10,),
                  //login button
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
                          login();
                        }
                      }, 
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                        )
                      ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(onPressed: (){
                        Navigator.push(context, 
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen()
                          ));
                      }, 
                      child: const Text(
                        "Sign up", 
                        style: TextStyle(
                          color: Colors.red
                          ),
                        )
                      )
                    ],
                  ),
            
                isLoginTrue ? const Text(
                  "username or password incorrect", 
                  style: TextStyle(color: Colors.redAccent),
                ) : const SizedBox()
                ],
              ),
            ),
            ),
            
        ),
      ),

    );
  }
}