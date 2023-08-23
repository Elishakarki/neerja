import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neerja/moviebloc/bloc/movie_bloc_bloc.dart';
import 'package:neerja/utility/fluttertoast.dart';
import 'package:neerja/utility/shared_preferences.dart';
import 'package:neerja/view/second_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginbloc/bloc/login_bloc_bloc.dart';
import 'model/htttpRequest.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'popularmovie/bloc/popularmovie_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();
  SharedPreferences userToken;
  userToken = await SharedPreferences.getInstance();

//       LoginPage() ,);
//       LoginPage() ,);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginBlocBloc>(
        create: (BuildContext context) => LoginBlocBloc(),
      ),
      

       BlocProvider<PopularmovieBloc>(
        create: (BuildContext context) => PopularmovieBloc(),
      ),
     BlocProvider<MovieBlocBloc>(
        create: (BuildContext context) => MovieBlocBloc(),
      ),
    ],
    child: MaterialApp(
       initialRoute: '/',

        debugShowCheckedModeBanner: false,
       routes: {
        '/': (context) => userToken.getString("firstname") == null
            ? LoginPage()
            : SecondScreen(),
              '/second': (context) => SecondScreen(),
       },
  ))
  );
}

const Color primaryColor = Colors.green;
const Color errorColor = Colors.red;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 final FocusNode _firstFocus = FocusNode();
 final FocusNode _secondFocus = FocusNode();
  String? email;

  dynamic password;
  ApiService apiService = ApiService();
  UserSimplePreferences preferences = UserSimplePreferences();
  bool isLoggedIn = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
   LoginBlocBloc authBloc = LoginBlocBloc();
  TextEditingController passwordController = TextEditingController();
  String? _validateEmail(String value) {
    if (
      value.isEmpty) {
      return 'Please enter an email';
    }
    // You can add more advanced email validation here if needed
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    // You can add more password validation rules here if needed
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      // For example, check if email and password match a stored user
      // If valid, navigate to the next screen
      // If not valid, show an error message
    }
  }

@override
void dispose() {
  _firstFocus.dispose();
  _secondFocus.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text(" Login Page"),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: TextFormField(
                            focusNode: _firstFocus,
                            textInputAction: TextInputAction.next,
                            onSaved: (nevl) {
                              emailController.text = nevl!;
                            },
        
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return " please Enter the Email Adress";
                              }
                              return null;
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              label: const Text(" Email "),
                              hintText: " karkielisha222@gmail.com",
                              errorBorder: const OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide:
                                    BorderSide(width: 3, color: Colors.red),
                              ),
                            ),
                            // onChanged: (value) {
                            //   emailController.text = value;
        
                            // },) ,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              focusNode: _secondFocus,
                                textInputAction: TextInputAction.done,
                              onSaved: (nevalue) {
                                passwordController.text = nevalue!;
                              },
                              controller: passwordController,
        
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return " plz add a password";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "9238877^%&",
                                label: const Text(" password"),
                              ),
                              keyboardType: TextInputType.emailAddress,
        
                              //      decoration: const InputDecoration(
                              //    errorBorder: OutlineInputBorder( //<-- SEE HERE
                              //  borderSide: BorderSide(
                              //      width: 3, color: Colors.redAccent),
                              //    ),
                              //      ),
                            ),
                          ),
                        ),
                        // onChanged: (value) {
                        //    passwordController.text = value;
                        // },) ,
        
                        const SizedBox(
                          height: 20,
                        ),
                        // BlocBuilder<LoginBlocBloc, LoginBlocState>(
                        //     bloc: authBloc,
                        //     builder: (context, state) {
                        //      log(state.toString());
                        //       if (state is LoginBlocLoadingState)
                        //         return Center(
                        //           child: CircularProgressIndicator(),
                        //         );
                        //       else if (state is LoginBlocPressedState) {
                        //         log(state.response.toString());
                        //         log(isLoggedIn.toString());
                        //         if (state.response["success"] != null) {
                        //           Navigator.pushReplacement(
                        //             context,
                        //             MaterialPageRoute(
                        //               builder: (context) => SecondScreen(),
                        //             ),
                        //           );
                        //         } else {
                        //           Fluttertoast.showToast(msg: " Invalid user");
                        //         }
                        //       } else if (state is LoginBlocErrorState) {
                        //         Fluttertoast.showToast(msg: state.erroMessage);
                        //       }
                        //       return Container();
                        //     }),
        
        
                        BlocConsumer<LoginBlocBloc, LoginblocState>(
                          bloc:authBloc,
                          listener: (context, state) {
                           
                            if(state is LoginBlocPressedState){
        
                         
                              if(state.response["success"]=="Success: API session successfully started!"){
        Navigator.pushNamed(context, '/second');

        emailController.clear();
        passwordController.clear();
          isLoggedIn= false;
                             
                              }
                              else{
                                setState(() {
                                  isLoggedIn =false;
                                });
                                   Utilites.showInToast( "Invalid users");
                              }
        
                            }
                             if(state is LoginBlocErrorState){
                                 Utilites.showInToast(state.erroMessage);
                              }
                            
                          },
                          builder: (context, state) {
                            if(state is LoginBlocLoadingState){
                              return  CircularProgressIndicator();
                            }
                            
                           else {
                            return FloatingActionButton.extended(
                              backgroundColor: Colors.green,
                              onPressed: () async {
                                        setState(() {
                                isLoggedIn = false; // Set isLoggedIn to false after login
                                          });
                                if (_formKey.currentState!.validate()) {
                             
                                  authBloc.add(LoginButtonPressedEvent(
                                      email:emailController.text, password:passwordController.text));
                                     
                                      setState(() {
                                  isLoggedIn = true;
                                });
                                //  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => SecondScreen(),));
                                } else {
                                  Utilites.showInToast(" Plz enter email and password ");
                                }
                                
        
                                
                                // final response = res.response;
                              },
                              label: isLoggedIn
                                  ? Container(
                                      color: Colors.green,
                                      width: 48,
                                      height: 48,
                                      child: CircularProgressIndicator(
                                        strokeWidth:
                                            3.0, // Adjust the strokeWidth to change the thickness
                                        backgroundColor: Colors
                                            .grey, // Set the background color
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.blue), // Set the color
                                      ),
                                    )
                                  : Text("Submit "),
                            );
                          
                          }
                           
                          },
                        ),
                      ]))),
        ));
  }
}


class ContainerListScreen extends StatefulWidget {
  const ContainerListScreen({super.key});

  @override
  _ContainerListScreenState createState() => _ContainerListScreenState();
}

class _ContainerListScreenState extends State<ContainerListScreen> {
  int _selectedIndex = -1;

  List<ContainerInfo> containerInfoList = [
    ContainerInfo('Container 1', 'Information for Container 1'),
    ContainerInfo('Container 2', 'Information for Container 2'),
    ContainerInfo('Container 3', 'Information for Container 3'),
  ];

  void _onContainerTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selectable Containers')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: containerInfoList.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedIndex == index;
                final containerInfo = containerInfoList[index];

                return GestureDetector(
                  onTap: () => _onContainerTap(index),
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    color: isSelected ? Colors.green : Colors.white,
                    child: Text(containerInfo.title),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          _selectedIndex != -1
              ? Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        containerInfoList[_selectedIndex].title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(containerInfoList[_selectedIndex].description),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class ContainerInfo {
  final String title;
  final String description;

  ContainerInfo(this.title, this.description);
}
