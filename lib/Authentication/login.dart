import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool isVisible = false;
  
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
                      TextButton(onPressed: (){}, child: const Text("Sign up", style: TextStyle(color: Colors.red),))
                    ],
                  )
              
                ],
              ),
            ),
            ),
            
        ),
      ),

    );
  }
}