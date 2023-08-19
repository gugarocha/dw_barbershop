import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/providers/application_providers.dart';
import '../../../core/ui/helpers/form_helper.dart';
import '../../../core/ui/helpers/messages.dart';
import '../../../core/ui/widgets/avatar_widget.dart';
import '../../../core/ui/widgets/barbershop_loader.dart';
import '../../../core/ui/widgets/hours_panel.dart';
import '../../../core/ui/widgets/weekdays_panel.dart';
import '../../../model/barbershop_model.dart';
import 'employee_register_state.dart';
import 'employee_register_vm.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerAdm = false;

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarbershopProvider);

    ref.listen(
      employeeRegisterVmProvider.select((state) => state.status),
      (_, status) {
        switch (status) {
          case EmployeeRegisterStateStatus.initial:
            break;
          case EmployeeRegisterStateStatus.success:
            Messages.showSuccess('Colaborador registrado com sucesso', context);
            Navigator.of(context).pop();
          case EmployeeRegisterStateStatus.error:
            Messages.showError('Erro ao registar colaborador', context);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: barbershopAsyncValue.when(
        loading: () => const BarbershopLoader(),
        error: (error, stackTrace) {
          log(
            'Erro ao carregar a página',
            error: error,
            stackTrace: stackTrace,
          );
          return const Center(
            child: Text('Erro ao carregar a página'),
          );
        },
        data: (barbershopModel) {
          final BarbershopModel(
            :openingDays,
            :openingHours,
          ) = barbershopModel;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
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
                                employeeRegisterVm.setRegisterAdm(registerAdm);
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
                              onTapOutside: (_) => context.unfocus(),
                              controller: nameEC,
                              validator: registerAdm
                                  ? null
                                  : Validatorless.required(
                                      'Nome é obrigatório',
                                    ),
                              decoration: const InputDecoration(
                                label: Text('Nome'),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              onTapOutside: (_) => context.unfocus(),
                              controller: emailEC,
                              validator: registerAdm
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required(
                                        'E-mail é obrigatório',
                                      ),
                                      Validatorless.email(
                                        'Digite um e-mail válido',
                                      ),
                                    ]),
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                label: Text('Email'),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              onTapOutside: (_) => context.unfocus(),
                              controller: passwordEC,
                              validator: registerAdm
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required(
                                        'Senha é obrigatória',
                                      ),
                                      Validatorless.min(
                                        6,
                                        'Senha deve conter no mínimo 6 caracteres',
                                      ),
                                    ]),
                              obscureText: true,
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
                        enabledDays: openingDays,
                        onDayPressed: employeeRegisterVm.addOrRemoveWorkdays,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      HoursPanel(
                        startTime: 6,
                        endTime: 23,
                        enabledTimes: openingHours,
                        onHourChanged: employeeRegisterVm.addOrRemoveWorkHours,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        onPressed: () {
                          switch (formKey.currentState?.validate()) {
                            case false || null:
                              Messages.showError(
                                'Existem campos inválidos',
                                context,
                              );
                            case true:
                              final EmployeeRegisterState(
                                workdays: List(isNotEmpty: hasWorkdys),
                                workhours: List(isNotEmpty: hasWorkhours),
                              ) = ref.watch(employeeRegisterVmProvider);

                              if (!hasWorkdys || !hasWorkhours) {
                                Messages.showError(
                                  'Por favor, selecione os dias e horários de atendimento',
                                  context,
                                );
                                return;
                              }

                              final name = nameEC.text;
                              final email = emailEC.text;
                              final password = passwordEC.text;

                              employeeRegisterVm.register(
                                name: name,
                                email: email,
                                password: password,
                              );
                          }
                        },
                        child: const Text('CADASTRAR COLABORADOR'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
