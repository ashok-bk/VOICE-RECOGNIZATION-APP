import 'package:flutter/material.dart';
import 'package:project2/color_pallate.dart';
//import 'package:project2/feature_box.dart';
//import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //we can found this method in flutter documentation
  //final speechToText = SpeechToText();
  //String lastWords = '';
  SpeechToText speechToText = SpeechToText();
  var isListening = false;
  var text = 'HII! NOW YOU CAN SPEAK';
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTapDown: (details) async {
          if (!isListening) {
            var voice = await speechToText.initialize();
            if (voice) {
              setState(() {
                isListening = true;
                speechToText.listen(
                  onResult: (result) {
                    setState(() {
                      text = result.recognizedWords;
                    });
                  },
                );
              });
            }
          }
        },
        // button working
        onTapUp: (details) {
          setState(() {
            isListening = false;
          });
          speechToText.stop();
        },
        child: const CircleAvatar(
          backgroundColor: Colors.green,
          radius: 35,
          child: Icon(
            Icons.mic,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Voice Assistant'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      // for virtual assistant profile
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('Asset/images/customer-service.png'),
                    ),
                  ),
                )
              ],
            ),
            //text displaying
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              margin: const EdgeInsets.only(bottom: 150),
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.black54,
                      ),
            ),
            )
            
            
          ],
        ),
      ),
    );
  }
}
