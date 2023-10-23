import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  _CustomSlider createState() => _CustomSlider();
}

class _CustomSlider extends State<CustomSlider> {
  //default value of the slider 
  double current_value = 500;
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

    Slider slider = Slider(
          activeColor: Colors.redAccent[700],
          inactiveColor: Color.fromARGB(136, 156, 152, 152),
          value: current_value,
          max: maxValue,
          onChanged: (double value) {setState(() { current_value = value; });}, //update slider value
    );

    TextFormField textInput = TextFormField( 
            onChanged:(value){ setState(() {if(0 <= double.parse(value) && double.parse(value) <= maxValue){current_value = double.parse(value); }});}, // set a value between 0-1023
            controller: inputTextController, 
            decoration: InputDecoration( border: OutlineInputBorder(), hintText: current_value.round().toString()) );

    return Column( 
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(
          width: 100,
          child: textInput), 
          ElevatedButton(onPressed: () { return null; /*TODO: call adapt speed service*/}, child: Text("Adapt speed"),)],)
        ,
        slider
      ]);
      
  }
}