// @license
// Copyright (c) 2019 - 2022 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'package:flutter_test/flutter_test.dart';
import 'package:gg_btle/src/characteristics_connection.dart';

main() {
  final characteristicConnection = exampleCharacteristicConnection();

  group('Priority', () {
    test('index', () {
      expect(Priority.low.index, 0);
      expect(Priority.normal.index, 1);
      expect(Priority.high.index, 2);
    });
  });

  group('PriorityTransmissionResult', () {
    test('index', () {
      expect(TransmissionResult.willSendData.index, 0);
      expect(TransmissionResult.skippedRepeatedData.index, 1);
      expect(TransmissionResult.exceedsMaxSize.index, 2);
    });
  });

  group('CharacteristicConnection', () {
    test('should be instantiated', () {
      expect(characteristicConnection, isNotNull);
    });
  });
}
