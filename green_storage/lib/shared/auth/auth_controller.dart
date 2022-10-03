import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController
{
  UserModel? _user;

  // Only calls when is loged, null safety
   UserModel get user => _user!; 

  void setUser(BuildContext context, UserModel? user)
  {
    if(user != null)
    {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(context, "/home");
    } else 
    {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }
  //flutter build apk --release
  
  Future<void> saveUser(UserModel user) async
  {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('user', user.toJSON());
    return;
  }

  Future<void> currentUser(BuildContext context) async
  {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 3));
    
    if(instance.containsKey("user"))
    {
      final json = instance.get("user") as String;
      setUser(context, UserModel.fromJSON(json));
      return;
    } else
    {
      setUser(context, null);
    }

  }

}