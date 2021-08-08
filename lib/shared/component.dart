import 'package:flutter/material.dart';


Widget defaultFormField({
  required TextEditingController controller,
  required dynamic label,
  required IconData prefix,
  TextInputType ?keyboardType,
  Function(String)? onSubmit,
  onChange,
  onTap,
  required String? Function(String?) validate,
  bool isPassword = false,
  IconData ?suffix,
  suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix,),
        suffixIcon: suffix != null ? IconButton(onPressed: suffixPressed, icon: Icon(suffix)) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
      ),
    );

Widget defaultButton({
  required VoidCallback onTap,
  required String text,
  double? width = 150,

}) => Container(
  height: 40,
  width: width,
  decoration: BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(30),),
  child: MaterialButton(
    onPressed: onTap,
    child: Text(
      '$text',
      style: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
    ),
  ),
);


