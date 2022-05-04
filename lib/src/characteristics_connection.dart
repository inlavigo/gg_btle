// @license
// Copyright (c) 2019 - 2022 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'dart:async';
import 'dart:typed_data';

import 'package:gg_btle/src/header.dart';
import 'package:gg_value/gg_value.dart';

import 'typedefs.dart';

// .............................................................................
enum Priority {
  low,
  normal,
  high,
}

// .............................................................................
enum TransmissionResult {
  didSendData,
  skippedRepeatedData,
  exceedsMaxSize,
}

// ...........................................................................
const sendQueueDefaultMaxSize = 8;

// ...........................................................................
enum SendQueueKey {
  replacementKey,
  dataCurrentlyBeeingSent,
  completionBlock,
  debugString,
}

// .............................................................................
typedef DataReceivedCallback = Function({
  CharacteristicConnection connection,
  ByteBuffer data,
});

// .............................................................................
typedef Callback = void Function(CharacteristicConnection);

// #############################################################################
class Delegate {
  const Delegate({
    this.onConnect,
    this.onDisConnect,
    this.onDataReceived,
    this.onCancelReceiving,
    this.onFinishSendingData,
    this.onCancelSendingData,
  });

  // ...........................................................................
  final Callback? onConnect;
  final Callback? onDisConnect;
  final Callback? onCancelReceiving;
  final DataReceivedCallback? onDataReceived;
  final Callback? onFinishSendingData;
  final Callback? onCancelSendingData;
}

// #############################################################################
class NativeEndpoint {
  const NativeEndpoint({
    required this.dataSource,
    required this.dataSink,
    required this.isConnected,
  });

  final Stream<ByteBuffer> dataSource;
  final DataSink dataSink;
  final GgValueStream<bool> isConnected;
}

// .............................................................................
NativeEndpoint exampleNativeEndpoint() {
  return NativeEndpoint(
    dataSink: (data) => Future.value(null),
    dataSource: StreamController<ByteBuffer>().stream,
    isConnected: GgValue<bool>(seed: false).stream,
  );
}

// #############################################################################
class CharacteristicConnection {
  CharacteristicConnection({
    required this.uuid,
    required this.alias,
    required this.nativeEndpoint,
  });

  // ...........................................................................
  final UUID uuid;
  final Alias alias;
  final NativeEndpoint nativeEndpoint;

  // ...........................................................................
  bool isConnected = false;

  // ...........................................................................
  Future<TransmissionResult> transmit({
    required ByteBuffer data,
    String? debugString,
    bool? replacementKey,
  }) {
    return Future.value(TransmissionResult.didSendData);
  }

  // ...........................................................................
  void deletePendingMessages() {}

  // ...........................................................................
  void addDelegate(Delegate delegate) {}

  // ...........................................................................
  void removeDelegate(Delegate delegate) {}

  // ...........................................................................
  bool get isCurrentlySending => false;

  // ...........................................................................
  NativePeripheral get peripheral => 0;

  // ######################
  // Private
  // ######################

  static void writeHeader(BytesBuilder buffer, int payloadSize) {
    buffer.addByte(btleStartFlag);
    buffer.addByte(payloadSize);
  }
}

// #############################################################################

typedef CharacteristicsConnectionMap = Map<String, CharacteristicConnection>;

// #############################################################################
CharacteristicConnection exampleCharacteristicConnection() {
  return CharacteristicConnection(
    alias: 'exampleCharacteristicConnection',
    uuid: '17855A5C-741F-4F1A-90D1-BD868A99221F',
    nativeEndpoint: exampleNativeEndpoint(),
  );
}
