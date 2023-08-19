import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../../core/providers/application_providers.dart';
import '../../../model/barbershop_model.dart';
import '../../../repositories/user/user_repository.dart';
import 'employee_register_state.dart';

part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVm extends _$EmployeeRegisterVm {
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  void setRegisterAdm(bool isRegisterAdm) {
    state = state.copyWith(registerAdm: isRegisterAdm);
  }

  void addOrRemoveWorkdays(String weekday) {
    final EmployeeRegisterState(:workdays) = state;

    if (workdays.contains(weekday)) {
      workdays.remove(weekday);
    } else {
      workdays.add(weekday);
    }

    state = state.copyWith(workdays: workdays);
  }

  void addOrRemoveWorkHours(int hour) {
    final EmployeeRegisterState(:workhours) = state;

    if (workhours.contains(hour)) {
      workhours.remove(hour);
    } else {
      workhours.add(hour);
    }

    state = state.copyWith(workhours: workhours);
  }

  Future<void> register({
    String? name,
    String? email,
    String? password,
  }) async {
    final EmployeeRegisterState(:registerAdm, :workdays, :workhours) = state;

    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final UserRepository(
      :registerAdmAsEmployee,
      :registerEmployee,
    ) = ref.read(userRepositoryProvider);

    final Either<RepositoryException, Nil> resultRegister;

    if (registerAdm) {
      final dto = (
        workdays: workdays,
        workHours: workhours,
      );

      resultRegister = await registerAdmAsEmployee(dto);
    } else {
      final BarbershopModel(:id) =
          await ref.watch(getMyBarbershopProvider.future);

      final dto = (
        barbershopId: id,
        name: name!,
        email: email!,
        password: password!,
        workdays: workdays,
        workHours: workhours,
      );

      resultRegister = await registerEmployee(dto);
    }

    switch (resultRegister) {
      case Success():
        state = state.copyWith(status: EmployeeRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStateStatus.error);
    }

    asyncLoaderHandler.close();
  }
}
