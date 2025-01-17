import 'dart:convert';

import 'package:equation_solver_cli/equation_solver_cli.dart';
import 'package:test/test.dart';

import 'common_process.dart';

void main() {
  group("Testing the 'Console' class", () {
    test('Making sure that it can be built correctly', () {
      const console = Console(
        args: [
          'a',
          'b',
        ],
      );

      expect(console.args, orderedEquals(<String>['a', 'b']));
    });

    test(
      'Making sure that, when the argument list length is not 1, an error '
      'message is displayed',
      () async {
        final process = await createProcess();

        // Converting into a stream
        final stream = process.stdout
            .transform(
              const Utf8Decoder(),
            )
            .transform(
              const LineSplitter(),
            );

        // Expected output
        const expectedOutput = ' > Error: exactly one argument is required '
            'but 0 have been provided).';

        process.stdin.writeln('.');

        await expectLater(
          stream,
          emitsAnyOf(
            ['', expectedOutput, ''],
          ),
        );
      },
    );
  });
}
