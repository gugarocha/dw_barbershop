import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/ui/constants.dart';
import '../../../core/ui/widgets/barbershop_loader.dart';
import '../../../model/user_model.dart';
import 'appointment_ds.dart';
import 'employee_schedule_vm.dart';

class EmployeeSchedulePage extends ConsumerStatefulWidget {
  const EmployeeSchedulePage({super.key});

  @override
  ConsumerState<EmployeeSchedulePage> createState() =>
      _EmployeeSchedulePageState();
}

class _EmployeeSchedulePageState extends ConsumerState<EmployeeSchedulePage> {
  late DateTime dateSelected;
  var ignoreFirstLoad = true;

  @override
  void initState() {
    final DateTime(:year, :month, :day) = DateTime.now();
    dateSelected = DateTime(year, month, day, 0, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel(id: userId, :name) =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    final scheduleAsync =
        ref.watch(EmployeeScheduleVmProvider(userId, dateSelected));

    final employeeScheduleVm =
        ref.read(employeeScheduleVmProvider(userId, dateSelected).notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 44,
          ),
          scheduleAsync.when(
            loading: () => const BarbershopLoader(),
            error: ((error, stackTrace) {
              log(
                'Erro ao carregar agendamento',
                error: error,
                stackTrace: stackTrace,
              );
              return const Center(
                child: Text(
                  'Erro ao carregar a página',
                ),
              );
            }),
            data: (schedules) {
              return Expanded(
                child: SfCalendar(
                  allowViewNavigation: true,
                  view: CalendarView.day,
                  showNavigationArrow: true,
                  todayHighlightColor: ColorsConstants.brow,
                  showDatePickerButton: true,
                  showTodayButton: true,
                  dataSource: AppointmentDs(schedules: schedules),
                  onViewChanged: (viewChangedDetails) {
                    if (ignoreFirstLoad) {
                      ignoreFirstLoad = false;
                      return;
                    }

                    employeeScheduleVm.changeDate(
                      userId,
                      viewChangedDetails.visibleDates.first,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
