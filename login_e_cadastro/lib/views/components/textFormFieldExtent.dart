import 'package:flutter/material.dart';

class TextFormFieldExt extends StatelessWidget {

  String _labelText;
  Icon _prefixIcon;
  TextEditingController _controller;
  TextInputType _keyboardType;
  bool _obscureText;
  Function(String) _validator;

  TextFormFieldExt(
      {String labelText,
      Icon prefixIcon,
      TextEditingController controller,
      TextInputType keyboardType,
      bool obscureText,
      Function(String) validator}) {
    this._labelText = labelText;
    this._prefixIcon = prefixIcon;
    this._controller = controller;
    this._keyboardType = keyboardType;
    this._obscureText = obscureText;
    this._validator = validator;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextFormField(
        controller: _controller,
        keyboardType: _keyboardType ?? TextInputType.text,
        obscureText: _obscureText ?? false,
        validator: _validator,
        decoration: InputDecoration(
            labelText: _labelText ?? '',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            prefixIcon: _prefixIcon),
      ),
    );
  }
}
