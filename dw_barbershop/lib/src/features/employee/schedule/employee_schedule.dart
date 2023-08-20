import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/ui/constants.dart';
import '../../../model/user_model.dart';
import 'appointment_ds.dart';

class EmployeeSchedule extends StatelessWidget {
  const EmployeeSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final employeeData =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          Text(
            employeeData.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 44,
          ),
          Expanded(
            child: SfCalendar(
              allowViewNavigation: true,
              view: CalendarView.day,
              showNavigationArrow: true,
              todayHighlightColor: ColorsConstants.brow,
              showDatePickerButton: true,
              showTodayButton: true,
              dataSource: AppointmentDs(),
              appointmentBuilder: (context, calendarAppointmentDetails) {
                return Container(
                  decoration: BoxDecoration(
                    color: ColorsConstants.brow,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      calendarAppointmentDetails.appointments.first.subject,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
              onTap: (calendarTapDetails) {
                if (calendarTapDetails.appointments != null &&
                    calendarTapDetails.appointments!.isNotEmpty) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Client ${calendarTapDetails.appointments?.first.subject}',
                              ),
                              Text(
                                'Horário ${dateFormat.format(calendarTapDetails.date ?? DateTime.now())}',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
