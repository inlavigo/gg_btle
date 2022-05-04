// @license
// Copyright (c) 2019 - 2022 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'dart:typed_data';

import 'typedefs.dart';

const UInt32 btleChunkSize = 500;
const UInt8 btleStartFlag = 0xFF;
const UInt8 btleHeaderSize = 2;
const UInt8 btleMaxChunksPerMessage = 0xFE; //0xFF is reserved
const UInt32 btleMessageMaxSize =
    btleChunkSize * btleMaxChunksPerMessage - btleHeaderSize;
const UInt8 btlePacketNumberSize = 1;

class BtleHeader {
  BtleHeader({required this.payloadSize});

  static const UInt8 startFlag = btleStartFlag;
  final UInt8 payloadSize;

  writeToByteBuffer(ByteBuffer byteBuffer) {}
}
