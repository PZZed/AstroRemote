import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  _CustomSlider createState() => _CustomSlider();
}

class _CustomSlider extends State<CustomSlider> {
  //default value of the slider 
  int current_value = 500;

  //max value of the slider
  double maxValue = 1023;

  //text controller -> update slider value when a value is submitted
  final inputTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

 TextFormField textInput = TextFormField( 
            keyboardType: TextInputType.number,
            onChanged:(value){ setState(() {
              if((value.isNotEmpty) && (0 <= int.parse(value) && int.parse(value) <= maxValue))
              {
                current_value = int.parse(value); 
              }});},
              
            // set a value between 0-1023
            controller: inputTextController, 
            decoration: InputDecoration( border: OutlineInputBorder(), hintText: current_value.round().toString()) );

    Slider slider = Slider(
          activeColor: Colors.redAccent[700],
          inactiveColor: Color.fromARGB(136, 156, 152, 152),
          value: current_value.toDouble(),
          max: maxValue,
          onChanged: (double value) {setState(() { 
            current_value = value.toInt();
            inputTextController.text = value.round().toString();
           });}, //update slider value
    );

   

    return Column( 
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(scale:1.5, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(
          width: 60,
          child: textInput),SizedBox(width: 5), 
          ElevatedButton(
            onPressed :(){return null;} /*TODO: call adapt speed service, if "suivi activated,else return null to desactivate button"*/,
            child: Text("Modifier vitesse"),
            style: ElevatedButton.styleFrom(primary: Colors.redAccent.shade700),)],))
        ,
        SizedBox(height: 20),
        slider
      ]);
      
  }
}