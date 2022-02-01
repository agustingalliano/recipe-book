import 'package:flutter/material.dart';
import 'package:recipe_book/src/api/user.api.dart';

class LoginPage extends StatefulWidget {
  BuildContext context;

  LoginPage(this.context, {Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _loading = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String userName = "";
  String password = "";
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formkey,
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 60),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan[300]!,
                      Colors.cyan[800]!,
                    ],
                  ),
                ),
                child: Image.asset('assets/images/logo.png',
                    color: Colors.white, height: 200),
              ),
              Transform.translate(
                offset: const Offset(0, -40),
                child: Center(
                    child: SingleChildScrollView(
                      child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 260, bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  decoration:
                                  const InputDecoration(labelText: "User: "),
                                  onSaved: (value) {
                                    userName = value!;
                                  },
                                  validator: (value) {
                                    if(value!=null){
                                      if(value.isEmpty){
                                        return "This field is required";
                                      }
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                TextFormField(
                                  decoration:
                                  const InputDecoration(labelText: "Password: "),
                                  onSaved: (value) {
                                    password = value!;
                                  },
                                  validator: (value) {
                                    if(value!=null){
                                      if(value.isEmpty){
                                        return "This field is required";
                                      }
                                    }
                                  },
                                  obscureText: true,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _login(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text("Sign in"),
                                        if (_loading)
                                          Container(
                                            height: 20,
                                            width: 20,
                                            margin: const EdgeInsets.only(left: 20),
                                            child: const CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                      ],
                                    )
                                ),
                                if(errorMessage.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      errorMessage,
                                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Not registered??',
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          '/register',
                                        );
                                      },
                                      child: const Text("Sign up"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    )),
              )
            ],
          ),
        )
    );
  }

  void _login(BuildContext context) async{
    if (!_loading) {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        setState(() {
          _loading = true;
          errorMessage = "";
        });
        bool ok = await UserApi.login(userName, password);
        if (ok) {
          Navigator.of(context).pushReplacementNamed("/home");
        } else {
          setState(() {
            errorMessage = "Incorrect user or password";
            _loading = false;
          });
        }
      }
    }
  }
}