// @license
// Copyright (c) 2019 - 2022 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import './characteristics_connection.dart';

import './typedefs.dart';

class Service {
  static const int undefinedProtocolVersion = 0;
  Service({
    required this.uuid,
    required this.alias,
    required this.protocolVersion,
    required this.characteristics,
  }) {
    _initCharacteristicsConnections();
  }

  // ...........................................................................
  /// The service's UUID. This ID can be scanned for.
  final String uuid;

  // ...........................................................................
  /// The service's alias for debugging purposes.
  final String alias;

  // ...........................................................................
  /// The protocol version.
  final int protocolVersion;

  // ...........................................................................
  /// A map assigning characteristic ids to aliases.
  final AliasToCharacteristicIds characteristics;

  // ...........................................................................
  /// The alias for the characterisic with ID.
  String? aliasForCharacteristicId(CharacteristicId id) =>
      _aliasForCharacteristic[id];

  // ...........................................................................
  /// Return true if the service has a characteristic with uuid.
  bool isSupportingCharacteristicWithId(CharacteristicId id) =>
      characteristicIds.contains(id);

  // ...........................................................................
  /// Returns the characteristic connection with uuid or null if none exists.
  CharacteristicConnection? characteristicConnectionWithId(
          CharacteristicId id) =>
      _characteristicConnectionsForId[id];

  // ...........................................................................
  ///
  CharacteristicConnection? characteristicConnectionWithAlias(Alias alias) =>
      _characteristicConnectionsForAlias[alias];

  // ...........................................................................
  List<CharacteristicConnection> get allCharacteristicsConnections =>
      _allCharacteristicConnections;

  // ...........................................................................
  void setIsDisconnected() {
    for (final connection in _allCharacteristicConnections) {
      connection.isConnected = false;
    }
  }

  // ...........................................................................
  List<String> get characteristicIds => _characteristicIds;

  // ...........................................................................
  bool rejectConnectionOnProtocolVersionMismatch = true;

  // ...........................................................................
  int unspecifiedProtocolVersion = 0;

  // ...........................................................................
  String get localName {
    final version = '$protocolVersion';
    const localNameMaxLength = 8;
    final maxLengthOfAlias = localNameMaxLength - version.length;
    final String shortAlias = alias.length > maxLengthOfAlias
        ? alias.substring(0, maxLengthOfAlias - 1)
        : alias;
    String result = '$shortAlias$version';
    return result;
  }

  // ######################
  // Private
  // ######################

  final List<String> _characteristicIds = [];
  final CharacteristicsConnectionMap _characteristicConnectionsForAlias = {};
  final CharacteristicIdToAlias _aliasForCharacteristic = {};
  final CharacteristicsConnectionMap _characteristicConnectionsForId = {};
  final List<CharacteristicConnection> _allCharacteristicConnections = [];

  // ...........................................................................
  _initCharacteristicsConnections() {
    for (final alias in characteristics.keys) {
      final uuid = characteristics[alias]!;
      final connection = CharacteristicConnection(alias: alias, uuid: uuid);

      _characteristicIds.add(uuid);
      _aliasForCharacteristic[uuid] = alias;
      _characteristicConnectionsForAlias[alias] = connection;
      _allCharacteristicConnections.add(connection);
      _characteristicConnectionsForId[uuid] = connection;
    }
  }
}

// #############################################################################
Service exampleService({String alias = 'exampleService'}) {
  return Service(
    alias: alias,
    characteristics: {
      'characteristic01': 'C80BA784-4AB4-4968-ACA8-918674733AB1',
      'characteristic02': '42578549-19F2-44F2-9669-B142F1FD60C7',
    },
    protocolVersion: 1,
    uuid: 'FFD14388-B842-4F60-92E2-8B069CD87427',
  );
}
