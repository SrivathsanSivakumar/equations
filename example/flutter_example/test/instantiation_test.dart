import 'package:equations_solver/main.dart';
import 'package:equations_solver/routes/home_page.dart';
import 'package:equations_solver/routes/utils/no_results.dart';
import 'package:equations_solver/routes/utils/svg_images/types/sections_logos.dart';
import 'package:equations_solver/routes/utils/svg_images/types/vectorial_images.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore_for_file: prefer_const_constructors

/// The coverage report generated by `flutter test --coverage` doesn't take into
/// account those lines where a `const` constructor has a call to `super`. This
/// is something expected by the VM so very likely this behavior won't change.
///
/// In order to achieve 100% code coverage, this file calls some constructors
/// containing `super` calls **WITHOUT** the `const` keyword. In this way, the
/// coverage report tool can mark as "covered" even constructors with `super`
/// calls.
void main() {
  group('Testing constructors of the classes', () {
    test('Widgets constructors', () {
      expect(
        EquationsApp(),
        isA<EquationsApp>(),
      );
      expect(
        NoResults(),
        isA<NoResults>(),
      );
      expect(
        HomePage(),
        isA<HomePage>(),
      );
      expect(
        PolynomialLogo(),
        isA<PolynomialLogo>(),
      );
      expect(
        NonlinearLogo(),
        isA<NonlinearLogo>(),
      );
      expect(
        SystemsLogo(),
        isA<SystemsLogo>(),
      );
      expect(
        IntegralLogo(),
        isA<IntegralLogo>(),
      );
      expect(
        OtherLogo(),
        isA<OtherLogo>(),
      );
      expect(
        OtherComplexNumbers(),
        isA<OtherComplexNumbers>(),
      );
      expect(
        OtherMatrix(),
        isA<OtherMatrix>(),
      );
      expect(
        SquareMatrix(),
        isA<SquareMatrix>(),
      );
      expect(
        SquareRoot(),
        isA<SquareRoot>(),
      );
      expect(
        HalfRightAngle(),
        isA<HalfRightAngle>(),
      );
      expect(
        Atoms(),
        isA<Atoms>(),
      );
      expect(
        CartesianPlane(),
        isA<CartesianPlane>(),
      );
      expect(
        EquationSolution(),
        isA<EquationSolution>(),
      );
    });
  });
}
