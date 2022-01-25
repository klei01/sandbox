import 'package:flutter/material.dart';
import 'package:sandbox/body.dart';
import 'package:sandbox/timePeriodButton.dart';

class TimePeriodPicker extends StatelessWidget {
  final Function changeTitle;
  final Function pickDate;
  TimePeriodPicker(this.changeTitle, this.pickDate);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color.fromARGB(255, 40, 36, 69),
              ),
              child: Builder(builder: (context) {
                return IconButton(
                    iconSize: 30, 
                    onPressed:() => pickDate(),
                    icon: Icon(
                      Icons.calendar_today,
                      color: Color.fromARGB(255, 40, 36, 69),
                    ));
              })),
        ),
        VerticalDivider(
          color: Color.fromARGB(255, 40, 36, 69),
          width: 5,
          thickness: 3,
        ),
        Expanded(
          flex: 8,
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              TimePeriodButton("Last Hour", () => changeTitle("Last Hour",Period.hour)),
              TimePeriodButton("Last Day", () => changeTitle("Last Day",Period.day)),
            ],
          ),
        ),
      ]),
    );
  }
}
