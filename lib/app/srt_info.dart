import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/words.dart';

class SrtInfo extends Words {
  int start_time;
  int end_time;
  String text;
  String statusString;

  TextSpan? tempText = null;
  SrtInfo( this.start_time, this.end_time,   this.text,  this.statusString, String words_original, String pronunciation, String description) :super(words_original:words_original, pronunciation: pronunciation,description: description){
    getSrtText();
  }

  bool isMatch(int time) {
    if (start_time <= time && time <= end_time) {
      return true;
    }
    return false;
  }

  TextSpan? getSrtText() {
    if (tempText != null) {
      return tempText;
    }
    if (text.isEmpty) {
      return null;
    }
    var listtexts = _matchStringByIndexOf(text, statusString);
    List<InlineSpan>? listSpan = [];
    for (var element in listtexts) {
      if (statusString.toLowerCase() == element.toLowerCase()) {
        listSpan.add(TextSpan(
          text: element,
          style: const TextStyle(color: Color(0xFF7F57E6), fontSize: 20, fontWeight: FontWeight.bold),
        ));
      } else {
        listSpan.add(TextSpan(text: element, style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 20, ), ));
      }
    }
    tempText = TextSpan(children:listSpan);
    return tempText;
  }

  List<String> _matchStringByIndexOf(String parent, String child) {
    int index = -1;
    List<int> indexs = [];
    List<String> listtexts = [];
    if (child.isEmpty || child == "") {
      listtexts.add(parent);
      return listtexts;
    }
    do {
      index = parent.indexOf(child, index+1);
      if (index != -1) {
        indexs.add(index);
      }
    } while (index != -1);
    int textIndex = 0;
    for (var i = 0; i < indexs.length; i++) {
      if (textIndex <= indexs[i]) {
        listtexts.add(parent.substring(textIndex, indexs[i]));
        textIndex = indexs[i];
      }
      var childEndIndex = (child.length??0) + textIndex;
      listtexts.add(parent.substring(textIndex, childEndIndex));
      textIndex = childEndIndex;
      if (i == (indexs.length - 1) && textIndex < parent.length) {
        listtexts.add(parent.substring(textIndex));
      }
    }
    return listtexts;
  }
}
