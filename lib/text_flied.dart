import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  CustomTextField(this.label, this.controller, this.obscureText);
  @override
  State<StatefulWidget> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hide;
  @override
  void initState() {
    super.initState();
    hide = widget.obscureText;
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                primary: Color.fromARGB(255, 40, 36, 69),
              )),
              child: child);
        },
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null ){
      setState(() {
        widget.controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              letterSpacing: 1.5,
              color: Color.fromRGBO(40, 36, 69, 100),
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          Divider(
            height: 5.0,
            thickness: 0.0,
          ),
          TextField(
            style: TextStyle(color: Colors.white),
            controller: widget.controller,
            obscureText: hide,
            autocorrect: false,
            onTap: widget.label == "BIRTHDAY" ? () => _selectDate(context): null,
            enableSuggestions: false,
            decoration: InputDecoration(
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: Color.fromARGB(100, 255, 255, 255),
                      ),
                      onPressed: () {
                        setState(() {
                          hide = !hide;
                        });
                      },
                    )
                  : null,
              fillColor: Color.fromRGBO(40, 36, 69, 70),
              filled: true,
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(40, 36, 69, 100)),
                  borderRadius: (BorderRadius.circular(10.0))),
            ),
          ),
        ],
      ),
    );
  }
}
