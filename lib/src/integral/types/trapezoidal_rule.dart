import 'package:equations/equations.dart';

/// The "trapezoidal rule" is a technique for approximating the value of a
/// definite integral.
///
/// This algorithm requires a parameter `m` which indicates how many partitions
/// have to be computed by the algorithm. The bigger the value of `m`, the better
/// the result approximation.
class TrapezoidalRule extends NumericalIntegration {
  /// Expects the [function] to be integrated ad the integration bounds
  /// ([lowerBound] and [upperBound]).
  ///
  /// The [intervals] variable represents the number of parts in which the
  /// [lowerBound, upperBound] interval has to be split by the algorithm.
  const TrapezoidalRule({
    required String function,
    required double lowerBound,
    required double upperBound,
    int intervals = 20,
  }) : super(
          function: function,
          lowerBound: lowerBound,
          upperBound: upperBound,
          intervals: intervals,
        );

  @override
  IntegralResults integrate() {
    // The 'step' of the algorithm
    final h = (upperBound - lowerBound) / intervals;

    // The initial approximation of the result
    var integralResult =
        evaluateFunction(lowerBound) + evaluateFunction(upperBound);

    // The list containing the various guesses of the algorithm
    final guesses = List<double>.filled(intervals, 0);

    // The actual algorithm
    for (var i = 0; i < intervals; ++i) {
      final x = lowerBound + i * h;

      integralResult += 2 * evaluateFunction(x);
      guesses[i] = integralResult;
    }

    return IntegralResults(
      guesses: guesses,
      result: integralResult * h / 2,
    );
  }
}