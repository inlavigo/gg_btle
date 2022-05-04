// @license
// Copyright (c) 2019 - 2022 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'dart:typed_data';

typedef Alias = String;
typedef UUID = String;
typedef CharacteristicId = UUID;
typedef AliasToCharacteristicIds = Map<Alias, CharacteristicId>;
typedef CharacteristicIdToAlias = Map<CharacteristicId, Alias>;
typedef DataSink = Future<void> Function(ByteBuffer data);

typedef UInt32 = int;
typedef UInt8 = int;
typedef UInt64 = int;
typedef Byte = int;

// Todo: Replace by real classes
typedef NativePeripheralManager = int;
typedef NativeCharacteristic = int;
typedef NativeCentral = int;
typedef NativeCentrallManager = int;
typedef NativePeripheral = int;
