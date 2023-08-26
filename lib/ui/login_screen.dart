import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tasks/ui/singinscreen.dart';
import 'package:tasks/ui/successfulloginpage.dart';
import 'package:twitter_login/twitter_login.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  var ischeck = false;
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  var key = GlobalKey<FormState>();
  var auth = FirebaseAuth.instance;
  var obsecuretext = true;
  var twitterloging = TwitterLogin(
    apiKey: 'kJTCquuIwdfq5x0VwD6rkB9Nn',
    apiSecretKey: 'Utf3Juk4JU2fB7ChoI7jogzGEOS1M2HtXb0T27OBFENWNYLQ3p ',
    redirectURI:'socialauth://' ,
  );

  googlelogin()async{
    print('googlelogin method callted');
    var googlesignin = GoogleSignIn();
    try{
      var result = await googlesignin.signIn();
      if(result == null){
        return ;
      }
      final userData = await result.authentication;
      final credetial = GoogleAuthProvider.credential(
        accessToken:userData.accessToken,
        idToken: userData.idToken
      );
      var finalresult = await FirebaseAuth.instance.signInWithCredential(credetial);
      print('result ${result}');
      print(result.displayName);


    }
    catch(e){
      print('error ======= ${e.toString()}');
    }
  }

Future signInwithTwitter () async{
    final authresult = await twitterloging.loginV2();
    if(authresult.status == TwitterLoginStatus.loggedIn){
      try{
        final credential  = TwitterAuthProvider.credential(accessToken: authresult.authToken!,
            secret: authresult.authTokenSecret!);
        await auth.signInWithCredential(credential);
        final userdetails = authresult.user;
        var _name = userdetails!.name;


      }catch(e){
        print('error ==== ${e.toString()}');
      }
    }
}

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
                        child: Icon(Icons.person),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Icon(Icons.close_rounded)
                ],
              ),
              SizedBox(
                height: 30,
              ),
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
                        Icon(
                          Icons.star_rate_rounded,
                          size: 6,
                          color: Colors.red,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: emailcontroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter email';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password'),
                        Icon(
                          Icons.star_rate_rounded,
                          size: 6,
                          color: Colors.red,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(

                      obscureText: obsecuretext,
                      controller: passcontroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter password';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          suffix: GestureDetector(
                            onTap: (){
                              setState(() {
                                obsecuretext = !obsecuretext;
                              });
                            },
                            child:  obsecuretext ? Icon(Icons.visibility_off,color: Colors.grey,) : Icon(Icons.visibility),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: ischeck,
                                onChanged: (var val) {
                                  setState(() {
                                    ischeck = val!;
                                  });
                                }),
                            Text('Remember me')
                          ],
                        ),
                        Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        if (key.currentState!.validate()) {}
                        auth.signInWithEmailAndPassword(
                            email: emailcontroller.text.toString(),
                            password: passcontroller.text.toString());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text("Create a new account "),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => signupnscreen(),
                                  ));
                            },
                            child: Text('Sing up'))
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('or', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // Here is where we are going to implement google sign in functionality
              Card(
                elevation: 2.0,
                shadowColor: Colors.black,
                child: InkWell(
                  onTap: ()async{
                    await googlelogin().then((value) {print('succsful');}).onError((error, stackTrace) {print('error ====== ${error.toString()}');});
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/images/google.png'),height: 25,),
                        SizedBox(width: 9,),
                        Text('Google',style: TextStyle(fontWeight: FontWeight.w500),)
                      ],
                    ),
                    height: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Card(
                elevation: 2.0,
                shadowColor: Colors.black,
                child: InkWell(
                  onTap: (){
                    signInwithTwitter().then((value) {print('su');}).onError((error, stackTrace) {print('error ====== ${error.toString()} ');});
                  },
                  child: Container(

                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/images/twitter.png'),height: 18,),
                        SizedBox(width: 9,),
                        Text('Twitter',style: TextStyle(fontWeight: FontWeight.w500),)
                      ],
                    ),
                    height: 50,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
