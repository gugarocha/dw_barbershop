enum EmployeeRegisterStateStatus {
  initial,
  success,
  error,
}

class EmployeeRegisterState {
  final EmployeeRegisterStateStatus status;
  final bool registerAdm;
  final List<String> workdays;
  final List<int> workhours;

  EmployeeRegisterState.initial()
      : this(
          status: EmployeeRegisterStateStatus.initial,
          registerAdm: false,
          workdays: <String>[],
          workhours: <int>[],
        );

  EmployeeRegisterState({
    required this.status,
    required this.registerAdm,
    required this.workdays,
    required this.workhours,
  });

  EmployeeRegisterState copyWith({
    EmployeeRegisterStateStatus? status,
    bool? registerAdm,
    List<String>? workdays,
    List<int>? workhours,
  }) {
    return EmployeeRegisterState(
      status: status ?? this.status,
      registerAdm: registerAdm ?? this.registerAdm,
      workdays: workdays ?? this.workdays,
      workhours: workhours ?? this.workhours,
    );
  }
}
