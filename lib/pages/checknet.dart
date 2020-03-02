
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
  
checknet() async{
  bool result = await DataConnectionChecker().hasConnection;
  if(result == true) {
    return SnackBar(
      content: Text('Internet Conected'),
    );
  }else{
    return SnackBar(

      content: Text('Internet Not Conected'),

    );
      
    print('No internet :( Reason:');
    print(DataConnectionChecker().lastTryResults);
}
}