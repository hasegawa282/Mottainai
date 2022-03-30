// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:async';


// Future _pickDate(BuildContext context) async {
//     //DatePickerの初期値
//     final initialDate = DateTime.now();
//     //DatePickerを表示し、選択されたら変数に格納する
//     final newDate = await showDatePicker(
//         context: context,
//         //初期値を設定
//         initialDate: initialDate,
//         //選択できる日付の上限
//         firstDate: DateTime(DateTime.now().year - 2),
//         lastDate: DateTime(DateTime.now().year + 2));

//     //nullチェック
//     if (newDate != null) {
//       //選択された日付を変数に格納
//       setState(() => selectedDate = newDate);
//     } else {
//       //nullならば何もしない
//       return;
//     }
//   }