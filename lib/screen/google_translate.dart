import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({Key? key}) : super(key: key);

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  TextEditingController controller = TextEditingController();
   String translated = 'Translation';
   String  langCode = "en";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Translate"),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 20),
            child:   ListView(
              children:  [
     
               TextField(style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          hintText: 'Translate To ?'
                        ), 
                        controller: controller,
                        onChanged: (value) {
                        langCode = getLanguageCode(value);  
                      },),

               const SizedBox(height: 38,),
                      TextField(
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          hintText: 'Enter Text'
                        ),
                        onChanged: (text) async {

                            const apiKey = 'AIzaSyBzGm4KNuj94fqk0rXY7HipbVnbbD_wvbg';
                            String to = langCode;
                            final url = Uri.parse
                            ('https://translation.googleapis.com/language/translate/v2?target=$to&key=$apiKey&q=$text');
                            final response = await http.post(url);
                              if (response.statusCode == 200) {
                                    final body = json.decode(response.body);
                                    final translations = body['data']['translations'] as List;
                                    final translate1 = translations.first['translatedText'];
                                    setState(() {
                                      translated = translate1;
                                    });
                                  } else {
                                    throw Exception();
                                  }
                        },
                      ),
                      const Divider(height: 32,),
                      Text(translated, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),

            ],),
          ),);
  }
    static String getLanguageCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
      case 'French':
        return 'fr';
      case 'Italian':
        return 'it';
      case 'Russian':
        return 'ru';
      case 'Spanish':
        return 'es';
      case 'German':
        return 'de';
      default:
        return 'en';
    }
}
}