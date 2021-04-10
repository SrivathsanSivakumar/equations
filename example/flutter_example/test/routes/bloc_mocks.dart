import 'package:bloc_test/bloc_test.dart';
import 'package:equations_solver/blocs/dropdown/dropdown.dart';
import 'package:equations_solver/blocs/navigation_bar/navigation_bar.dart';
import 'package:equations_solver/blocs/nonlinear_solver/nonlinear_solver.dart';
import 'package:equations_solver/blocs/polynomial_solver/polynomial_solver.dart';
import 'package:mocktail/mocktail.dart';

// ===== PolynomialBloc bloc mock class ===== //
class MockPolynomialBloc extends MockBloc<PolynomialEvent, PolynomialState>
    implements PolynomialBloc {}

class MockPolynomialEvent extends Fake implements PolynomialEvent {}

class MockPolynomialState extends Fake implements PolynomialState {}

// ===== Nonlinear bloc mock class ===== //
class MockNonlinearBloc extends MockBloc<NonlinearEvent, NonlinearState>
    implements NonlinearBloc {}

class MockNonlinearEvent extends Fake implements NonlinearEvent {}

class MockNonlinearState extends Fake implements NonlinearState {}

// ===== Dropdown cubit mock class ===== //
class MockDropdownCubit extends MockCubit<String> implements DropdownCubit {}

// ===== Navigation cubit mock class ===== //
class MockNavigationCubit extends MockCubit<int> implements NavigationCubit {}