
import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart';

class  ApiService {
// Map<String,dynamic>  ?body;
// List ?  logindata  =[];
//   Future<> sendPostRequest(String ? email , String ? password) async {
//   final url = Uri.parse('https://khetifood.com/index.php?route=api/loginB2b');
//   log("11111111");
//   log(email.toString());
//   log(password.toString());
//   try {
//   final response = await http.post(
//     url,
   
//     body: {
//       "username": "rajiv",
//               "key":
//                   "ODAo7UQyaPbnxcWEj3c3wdPrQvRGzp4nojCGtnp6GR8bsT5TT2w0DaQ6E85GSTfCeGJsLYLV1LbtHh3Zaoh0G7ZMLU4NTZK1pWCbnEd3Aw8dv85zH0oEtOXGsBli58womjOgu4dbHtyPgZtEULVPTTyPCbMKRxQNuwznAuxZxfBbhKkPLJCa0mLe8fg4lN7Wy64YaZufmSmJnTWef1DtcM7k7wn0A45Yy1Z5vuGI5lAHKYM3vF1XNZHLTEJhJoSr",
//               "email": email!,
//               "password":password!,
//             }
             
//   );
//   //  Map<String,dynamic>obj =  jsonEncode(response.body)as Map<String, dynamic>;
//   if(response.statusCode ==200){
//    return response;
//    //ApiResponse(success: true, message:  " success", response: response.body);
//   }
//   //  return ApiResponse(success: true, message:obj['message'], response: response.body);
      
//   // }
//   // else{
//   // }


//   else{
// return ;
// //ApiResponse(success: false, message:" error login", response: null);
//   }
//   }
//   //  return ApiResponse(success: false, message: obj['message'], response: null) ; 
//   catch(e) {
     
// return  false;
// //ApiResponse(success: false, message: e.toString(), response: null);
//   }

// }

// }
userLogin( value) async {
  
    try {
      String url = 'https://khetifood.com/index.php?route=api/loginB2b';

      Response res = await post(Uri.parse(url),
      body: value
       );



      final responseBody = json.decode(res.body);
      final statusCode = res.statusCode;
    
      if (statusCode != 200 || responseBody == null) {
        throw "unable to login user";
      } else {
        return json.decode(res.body);
      }
    } on SocketException {
      return {"status": "No internet connection"};
    } catch (e) {
      throw e.toString();
    }
  }


}



  



