
import 'package:flutter/material.dart';

class SearchBarDecorations {
  static final InputDecoration SearchBarHeadDecoration =
    InputDecoration(
      prefix: const Padding(
          padding: EdgeInsets.fromLTRB(6, 8, 6, 0),
          child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 18
          )
      ),

      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(20),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(20),
      ),

      fillColor: Colors.white,
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.all(2),
    );

}