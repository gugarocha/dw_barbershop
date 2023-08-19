import 'package:flutter/material.dart';

import '../../../core/ui/widgets/avatar_widget.dart';
import '../../../core/ui/widgets/hours_panel.dart';
import '../../../core/ui/widgets/weekdays_panel.dart';

class EmployeeRegisterPage extends StatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  State<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends State<EmployeeRegisterPage> {
  var registerAdm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                const AvatarWidget(),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Checkbox.adaptive(
                      value: registerAdm,
                      onChanged: (_) {
                        setState(() {
                          registerAdm = !registerAdm;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'Sou administrador e quero me cadastrar como colaborador',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Offstage(
                  offstage: registerAdm,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Email'),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Senha'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                WeekdaysPanel(
                  enabledDays: ['Seg', 'Qua', 'Sab'],
                  onDayPressed: (String day) {},
                ),
                const SizedBox(
                  height: 24,
                ),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourChanged: (int hour) {},
                  enabledTimes: [6, 7, 8, 9, 13, 14, 15, 16],
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {},
                  child: const Text('CADASTRAR COLABORADOR'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
