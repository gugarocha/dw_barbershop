import 'package:flutter/material.dart';

import '../constants.dart';

class HoursPanel extends StatelessWidget {
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourChanged;
  final List<int>? enabledTimes;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourChanged,
    this.enabledTimes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Selecione os horários de atendimento',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            for (int i = startTime; i <= endTime; i++)
              TimeButton(
                enabledTimes: enabledTimes,
                label: '${i.toString().padLeft(2, '0')}:00',
                value: i,
                onPressed: onHourChanged,
              )
          ],
        ),
      ],
    );
  }
}

class TimeButton extends StatefulWidget {
  final String label;
  final int value;
  final ValueChanged<int> onPressed;
  final List<int>? enabledTimes;

  const TimeButton({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
    this.enabledTimes,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    var buttonColor = selected ? ColorsConstants.brow : Colors.white;
    final textColor = selected ? Colors.white : ColorsConstants.grey;
    final buttonBorderColor =
        selected ? ColorsConstants.brow : ColorsConstants.grey;

    final TimeButton(:enabledTimes, :label, :value, :onPressed) = widget;

    final disableTime = enabledTimes != null && !enabledTimes.contains(value);
    if (disableTime) {
      buttonColor = Colors.grey[400]!;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disableTime
          ? null
          : () {
              setState(() {
                selected = !selected;
                onPressed(value);
              });
            },
      child: Container(
        width: 64,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
          border: Border.all(
            color: buttonBorderColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
