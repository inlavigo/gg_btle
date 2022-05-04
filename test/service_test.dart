// @license
// Copyright (c) 2019 - 2022 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'package:flutter_test/flutter_test.dart';
import 'package:gg_btle/src/service.dart';

main() {
  final s = exampleService();

  group('Service', () {
    // #########################################################################
    test(
        'uuid, alias, protocolVersion, characteristics, aliasForCharacteristics',
        () {
      expect(s, isNotNull);
      expect(s.alias, 'exampleService');
      expect(s.protocolVersion, 1);
      expect(s.uuid, 'FFD14388-B842-4F60-92E2-8B069CD87427');
      expect(
        s.aliasForCharacteristicId('C80BA784-4AB4-4968-ACA8-918674733AB1'),
        'characteristic01',
      );
      expect(
          s.isSupportingCharacteristicWithId(
              'C80BA784-4AB4-4968-ACA8-918674733AB1'),
          true);

      expect(s.isSupportingCharacteristicWithId('UNKNOWN'), false);

      expect(
          s.characteristicConnectionWithId(
              'C80BA784-4AB4-4968-ACA8-918674733AB1'),
          isNotNull);

      expect(
        s.characteristicConnectionWithId('UNKNOWN'),
        isNull,
      );
    });

    test('characteristicConnectionWithAlias', () {
      expect(
        s.characteristicConnectionWithAlias('characteristic01'),
        isNotNull,
      );
      expect(
        s.characteristicConnectionWithAlias('unknown-characteristic'),
        isNull,
      );
    });

    test('allCharacteristicsConnections', () {
      expect(s.allCharacteristicsConnections.length, 2);
    });

    test('setIsDisconnected', () {
      for (final c in s.allCharacteristicsConnections) {
        c.isConnected = true;
      }

      expect(
        s.allCharacteristicsConnections.map((c) => c.isConnected),
        [true, true],
      );

      s.setIsDisconnected();

      expect(
        s.allCharacteristicsConnections.map((c) => c.isConnected),
        [false, false],
      );
    });

    test('characteristicIds', () {
      expect(s.characteristicIds, [
        'C80BA784-4AB4-4968-ACA8-918674733AB1',
        '42578549-19F2-44F2-9669-B142F1FD60C7'
      ]);
    });

    test('localName', () {
      expect(s.localName, 'exampl1');
      expect(exampleService(alias: 'abc').localName, 'abc1');
    });
  });
}
