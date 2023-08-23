

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:neerja/model/htttpRequest.dart';

import '../../utility/shared_preferences.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginblocState> {

  LoginBlocBloc() : super(LoginBlocInitialState()) {
    on<LoginBlocEvent>((event, emit) async{
     

      
     if(event is LoginButtonPressedEvent)  {
     if (event.email!.isEmpty || event.password!.isEmpty) {
       emit(LoginBlocErrorState("erroMessage"));
     }
      try {
     emit(LoginBlocLoadingState());
        ApiService apiService =ApiService();
   Map<String, dynamic> body = {
      "username": "rajiv",
              "key":
                  "ODAo7UQyaPbnxcWEj3c3wdPrQvRGzp4nojCGtnp6GR8bsT5TT2w0DaQ6E85GSTfCeGJsLYLV1LbtHh3Zaoh0G7ZMLU4NTZK1pWCbnEd3Aw8dv85zH0oEtOXGsBli58womjOgu4dbHtyPgZtEULVPTTyPCbMKRxQNuwznAuxZxfBbhKkPLJCa0mLe8fg4lN7Wy64YaZufmSmJnTWef1DtcM7k7wn0A45Yy1Z5vuGI5lAHKYM3vF1XNZHLTEJhJoSr",
              "email": event.email,
              "password":event.password,
            };
            final Map<String, dynamic> res = 
        await apiService.userLogin(body);
      
          if(res.containsKey("customer_id")){
                     UserSimplePreferences. setCustomerId(res['customer_id']);
                     UserSimplePreferences.setUsername(res["firstname"]);
                     UserSimplePreferences.setProfileUrl(res["logo"]);
                     UserSimplePreferences.setFirstname(res["firstname"]);
                     UserSimplePreferences.setLastname(res["lastname"]);
                     UserSimplePreferences.setTelephone(res["telephone"]);
      
     
    
                  }
             
              
      emit(LoginBlocPressedState(response: res));
      
      } catch (e) {
        emit(LoginBlocErrorState(e.toString()));
         
        
      }
     }
    });
    
  }
}
