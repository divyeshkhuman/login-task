
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasks/ui/login_screen.dart';

class signupnscreen extends StatefulWidget {
  const signupnscreen({Key? key}) : super(key: key);

  @override
  State<signupnscreen> createState() => _signupnscreenState();
}

class _signupnscreenState extends State<signupnscreen> {
  var ischeck = false;
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  var key = GlobalKey<FormState>();
  var auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        foregroundColor: Colors.orange,
                        backgroundColor: Colors.orange.shade50,
                        child: Icon(Icons.person),),

                      SizedBox(width: 10,),

                      Text('Login',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Icon(Icons.close_rounded)
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Login to your account - enjoy exclusive'),
                      Text('features and many more.'),
                    ],
                  )

                ],
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: key,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email'),
                        Icon(Icons.star_rate_rounded,size: 6,color: Colors.red,)
                      ],
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: emailcontroller,
                      validator: (val){
                        if(val!.isEmpty) {
                          return 'Enter email';
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password'),
                        Icon(Icons.star_rate_rounded,size: 6,color: Colors.red,)
                      ],
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: passcontroller,
                      validator: (val){
                        if(val!.isEmpty) {
                          return 'Enter password';
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.remove_red_eye),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: ischeck , onChanged: (var val){
                              setState(() {
                                ischeck = val!;
                              });
                            }),

                            Text('Remember me')
                          ],
                        ),
                        Text('Forgot password?',style: TextStyle(color: Colors.grey),),

                      ],
                    ),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: (){

                        if(key.currentState!.validate()){

                        }
                        auth.createUserWithEmailAndPassword(email: emailcontroller.text.toString(),
                            password: passcontroller.text.toString());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Sign up',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400)),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text("You have a already account  "),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => loginscreen(),));
                        }, child: Text('Login'))
                      ],
                    ),
                    SizedBox(height: 15,),


                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
