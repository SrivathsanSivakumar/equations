import 'package:equations/equations.dart';
import 'package:equations_solver/blocs/other_solvers/other_solvers.dart';
import 'package:equations_solver/localization/localization.dart';
import 'package:equations_solver/routes/other_page/matrix/matrix_output.dart';
import 'package:equations_solver/routes/utils/breakpoints.dart';
import 'package:equations_solver/routes/utils/result_cards/bool_result_card.dart';
import 'package:equations_solver/routes/utils/result_cards/complex_result_card.dart';
import 'package:equations_solver/routes/utils/result_cards/polynomial_result_card.dart';
import 'package:equations_solver/routes/utils/result_cards/real_result_card.dart';
import 'package:equations_solver/routes/utils/section_title.dart';
import 'package:equations_solver/routes/utils/svg_images/types/sections_logos.dart';
import 'package:equations_solver/routes/utils/svg_images/types/vectorial_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This widget shows the matrix analysis results produced by an [OtherBloc].
class MatrixAnalyzerResults extends StatelessWidget {
  /// Creates a [MatrixAnalyzerResults] widget.
  const MatrixAnalyzerResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // Separator line
        SizedBox(
          height: 80,
        ),

        // Showing the analysis results
        _SystemSolutions(),

        // Additional spacing
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

/// Either prints nothing, a loading widget or the analysis results.
class _SystemSolutions extends StatelessWidget {
  /// Creates a [_SystemSolutions] widget.
  const _SystemSolutions();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherBloc, OtherState>(
      builder: (context, state) {
        if (state is AnalyzedMatrix) {
          return _Results(
            transpose: state.transpose,
            cofactorMatrix: state.cofactorMatrix,
            inverse: state.inverse,
            trace: state.trace,
            rank: state.rank,
            characteristicPolynomial: state.characteristicPolynomial,
            eigenvalues: state.eigenvalues,
            determinant: state.determinant,
            isSymmetric: state.isSymmetric,
            isDiagonal: state.isDiagonal,
            isIdentity: state.isIdentity,
          );
        }

        if (state is OtherLoading) {
          return const _LoadingWidget();
        }

        return const SizedBox.shrink();
      },
    );
  }
}

/// Displayed while the bloc is processing the matrix.
class _LoadingWidget extends StatelessWidget {
  /// Creates a [_LoadingWidget] widget.
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Loading indicator
        const Padding(
          padding: EdgeInsets.only(
            bottom: 20,
          ),
          child: CircularProgressIndicator(),
        ),

        // Waiting text
        Text(context.l10n.wait_a_moment),
      ],
    );
  }
}

/// The matrix analysis results.
class _Results extends StatelessWidget {
  /// The transposed matrix.
  final RealMatrix transpose;

  /// The cofactor matrix.
  final RealMatrix cofactorMatrix;

  /// The inverse matrix.
  final RealMatrix inverse;

  /// The trace of the matrix.
  final double trace;

  /// The rank of the matrix.
  final int rank;

  /// The characteristic polynomial of the matrix.
  final Algebraic characteristicPolynomial;

  /// The eigenvalues of the matrix.
  final List<Complex> eigenvalues;

  /// The determinant of the matrix.
  final double determinant;

  /// Whether the matrix is diagonal or not.
  final bool isDiagonal;

  /// Whether the matrix is symmetric or not.
  final bool isSymmetric;

  /// Whether it's an identity matrix or not.
  final bool isIdentity;

  /// Creates a [_Results] widget.
  const _Results({
    required this.transpose,
    required this.cofactorMatrix,
    required this.inverse,
    required this.trace,
    required this.rank,
    required this.characteristicPolynomial,
    required this.eigenvalues,
    required this.determinant,
    required this.isDiagonal,
    required this.isSymmetric,
    required this.isIdentity,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimensions) {
        // Numerical properties
        final propertiesWidget = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Properties
            SectionTitle(
              pageTitle: context.l10n.properties,
              icon: const Atoms(),
            ),

            RealResultCard(
              value: rank * 1.0,
              leading: '${context.l10n.rank}: ',
            ),

            RealResultCard(
              value: trace,
              leading: '${context.l10n.trace}: ',
            ),

            RealResultCard(
              value: determinant,
              leading: '${context.l10n.determinant}: ',
            ),

            BoolResultCard(
              value: isDiagonal,
              leading: '${context.l10n.diagonal}: ',
            ),

            BoolResultCard(
              value: isSymmetric,
              leading: '${context.l10n.symmetric}: ',
            ),

            BoolResultCard(
              value: isIdentity,
              leading: '${context.l10n.identity}: ',
            ),
          ],
        );

        // Eigenvalues and characteristic polynomial
        final eigenvaluesWidget = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SectionTitle(
              pageTitle: context.l10n.characteristicPolynomial,
              icon: const PolynomialLogo(),
            ),
            PolynomialResultCard(
              algebraic: characteristicPolynomial,
            ),

            // Spacing
            const SizedBox(
              height: 20,
            ),

            SectionTitle(
              pageTitle: context.l10n.eigenvalues,
              icon: const EquationSolution(),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: eigenvalues.length,
              itemBuilder: (context, index) => ComplexResultCard(
                value: eigenvalues[index],
              ),
            ),
          ],
        );

        // Operations on the matrix
        final matricesWidget = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SectionTitle(
              pageTitle: context.l10n.matrices,
              icon: const SquareMatrix(),
            ),

            // Spacing
            const SizedBox(
              height: 20,
            ),

            MatrixOutput(
              matrix: transpose,
              description: context.l10n.transpose,
            ),

            // Spacing
            const SizedBox(
              height: 20,
            ),

            MatrixOutput(
              matrix: inverse,
              description: context.l10n.inverse,
            ),

            // Spacing
            const SizedBox(
              height: 20,
            ),

            MatrixOutput(
              matrix: cofactorMatrix,
              description: context.l10n.cofactor,
            ),
          ],
        );

        // For mobile devices - all in a column
        if (dimensions.maxWidth <= matricesPageDoubleColumn) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Numerical properties
              propertiesWidget,

              // Some spacing
              const SizedBox(
                height: 80,
              ),

              // Char. polynomial & eigenvalues
              eigenvaluesWidget,

              // Spacing
              const SizedBox(
                height: 80,
              ),

              // Inverse, transpose, cofactors...
              matricesWidget,
            ],
          );
        }

        // For wider screens - splitting numerical results in two columns
        return Wrap(
          spacing: 80,
          runSpacing: 40,
          alignment: WrapAlignment.spaceAround,
          runAlignment: WrapAlignment.center,
          children: [
            SizedBox(
              width: matricesPageColumnWidth,
              child: propertiesWidget,
            ),
            SizedBox(
              width: matricesPageColumnWidth,
              child: eigenvaluesWidget,
            ),
            SizedBox(
              width: matricesPageColumnWidth,
              child: matricesWidget,
            ),
          ],
        );
      },
    );
  }
}
