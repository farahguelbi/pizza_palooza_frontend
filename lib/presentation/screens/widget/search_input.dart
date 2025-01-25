import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final String hintText;
  final void Function(String)? onChanged;

  const SearchInput({
    Key? key,
    this.hintText = "Search for pizza",
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        
        
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor:  const Color(0x00000).withOpacity(0.4),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'Abhaya Libre',
            fontSize: 16,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFFFF1E6).withOpacity(0.6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}
