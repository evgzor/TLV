//
//  TlvDataParser.m
//  TVLParser
//
//  Created by Eugene Zorin on 06/07/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "TlvDataParser.h"
#import "TlvTag.h"

static const uint undefinedLenghtValueIndicator = 0x80;

@implementation TlvDataParser

-(Tlv*) parseConsructedTlvData: (NSData*) data {
  uint nextOffset = 0;
  return [self parseTlvData:data offset:0 nextOffset:&nextOffset];
}

-(Tlv*) parseTlvData:(NSData*) data offset:(uint)offset nextOffset:(uint*)nextOffset {
  
  uint tagBytesNumber = [self getTagBytesLenght:data offset:offset];
  
  if (tagBytesNumber + offset > data.length) {
    [NSException raise:@"Out of data lenght" format:@"%@", [NSString stringWithFormat:@"Offset = %d tagLenght = %d",offset, tagBytesNumber]];
  }

  TlvTag* tag = [[TlvTag alloc] init:data offset:offset lenght:tagBytesNumber];
  
  uint lenghtBytesNumber = [self getLenghtBytesOfLenght:data offset:offset + tagBytesNumber];
  uint valueLenght = [self getDataLenght:data offset:offset + tagBytesNumber];

  *nextOffset = offset + tagBytesNumber + lenghtBytesNumber + valueLenght;
  
  if (tag.isConstracted) {
    NSMutableArray* array = [NSMutableArray array];
    
    [self addArray:data offset:offset tagBytesLenght:tagBytesNumber dataBytesLenght:lenghtBytesNumber valueLenght:valueLenght andArray:array];
    
    return [[Tlv alloc] init:tag array:array];
    
  } else {
    
    uint dataLocation = offset + tagBytesNumber + lenghtBytesNumber;
    if (valueLenght > data.length - (offset + tagBytesNumber + lenghtBytesNumber)) {
      [NSException raise:@"Bad Data" format:@"Bad  location = %lu and lenght = %u for data", (unsigned long)dataLocation, valueLenght];
    }
    
    NSData* value = [data subdataWithRange:NSMakeRange(dataLocation , valueLenght)];
    
    return [[Tlv alloc] init:tag value:value];
  }
}

-(uint) getDataLenght: (NSData*) data offset:(uint) offset {
  uint8_t const*bytes = data.bytes;
  uint lenghtOfCodedLenth = [self getLenghtBytesOfLenght:data offset:offset];
  
  uint lenght = bytes[offset];
  
  if (lenghtOfCodedLenth > 1) {
    uint lengthBytesNumber = lenghtOfCodedLenth - 1;
    [[data subdataWithRange:NSMakeRange(offset + 1, lengthBytesNumber)] getBytes: &lenght length: sizeof(lengthBytesNumber)];
  }
  
  return lenght;
}

-(uint) getLenghtBytesOfLenght:(NSData*)data offset:(uint) offset {
  
  uint8_t const*bytes = data.bytes;
  uint lenght = 1;
  uint undefinedLenghtValue = undefinedLenghtValueIndicator;
  
  while (((uint)bytes[offset] & undefinedLenghtValue) != 0) {
    undefinedLenghtValue++;
    lenght = undefinedLenghtValue;
  }
  return lenght;
}



-(uint) getTagBytesLenght:(NSData*) data offset:(uint) offset {
  
  uint8_t const*bytes = data.bytes;
  uint lenght = 1;

  if ((bytes[offset] & 0x1F) == 0x1F) {//check if is contains more than 1 bytes
    lenght = 2;
    uint countedOffset = offset;
    //check 8-th bit if not zero continnue
    while ((bytes[countedOffset + 1] & undefinedLenghtValueIndicator) != 0) {
      lenght++;
      countedOffset++;
    }
  }
  return lenght;
}

- (void) addArray:(NSData*) data offset:(uint) offset
       tagBytesLenght:(uint)tagBytesLenght
       dataBytesLenght:(uint) dataBytesLenght
      valueLenght:(int) valueLenght
      andArray:(NSMutableArray*) array {
  
  uint startPosition = offset + tagBytesLenght + dataBytesLenght;
  
  while (startPosition < offset + dataBytesLenght + valueLenght) {
    uint nextOffset = 0;
    Tlv* tlv = [self parseTlvData:data offset:startPosition  nextOffset:&nextOffset];
    [array addObject:tlv];
    
    startPosition = nextOffset;
  }
}

@end
