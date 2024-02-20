import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  _CustomSlider createState() => _CustomSlider();
}

class _CustomSlider extends State<CustomSlider> {
  ///Valeur par défaut du slider
  int current_value = 500;

  ///Valeur max du slider
  double maxValue = 1023;

  /// Affiche la valeur du slider
  final inputTextController = TextEditingController();

  @override
  void dispose() {
    inputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  /// Affiche la valeur de la vitesse
 TextFormField textInput = TextFormField( 
            keyboardType: TextInputType.number,
            onChanged:(value){ setState(() {
              if((value.isNotEmpty) && (0 <= int.parse(value) && int.parse(value) <= maxValue))
              {
                current_value = int.parse(value); 
              }});},
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
           });},
    );

   
    /// Création du composant Texte + Slider
    return Column( 
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale:1.5, 
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 60,child: textInput),
            const SizedBox(width: 5), 
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.redAccent.shade700),
              onPressed :(){return null;} /*TODO: call adapt speed service, if "suivi activated,else return null to desactivate button"*/,
              child: const Text("Modifier vitesse"),
            )
          ],
          )
        ),
        const SizedBox(height: 20),
        slider
      ]);
      
  }
}