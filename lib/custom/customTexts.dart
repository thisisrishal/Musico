import 'package:flutter/material.dart';

richTextHead(String text,
    {double size = 16,
    Color color = Colors.white,
    FontWeight weight = FontWeight.bold}) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size, fontWeight: weight),
  );
}
