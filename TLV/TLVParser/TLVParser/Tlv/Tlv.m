//
//  Tlv.m
//  TVLParser
//
//  Created by Eugene Zorin on 06/07/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "Tlv.h"
#import "NSData+HexString.h"

@implementation Tlv
-(instancetype)init:(TlvTag *)tag array:(NSArray *)array {
  self = [super init];
  
  if (self) {
    _tag = tag;
    _array = array;
    _constracted = tag.isConstracted;
    _primitive = !_constracted;
  }
  return self;
}

-(instancetype)init:(TlvTag *)tag value:(NSData *)value {
  self = [super init];
  
  if (self) {
    _tag = tag;
    _value = value;
    _constracted = tag.isConstracted;
    _primitive = !_constracted;
  }
  return self;
}

-(uint)lenghtOfLenght {
  uint valueLenght = (uint)self.value.length;
  uint undefinedLenghtValue = 1;
  while ((valueLenght & 0x80) != 0) {
    undefinedLenghtValue++;
  }
  return undefinedLenghtValue;
}

-(uint)lenght {
  uint tagLenght = (uint)self.tag.lenght;
  uint valueLenght = (uint)self.value.length;
  uint lenght = [self lenghtOfLenght];
  if (self.constracted) {
    uint tlvLenght = tagLenght;
    for (Tlv* tlv in self.array) {
      tlvLenght += tlv.lenght;
    }
    return tlvLenght + lenght;
  } else {
  
    return   tagLenght + lenght + valueLenght;
  }
}

-(NSString *)printTlvStructureWithOffsetString: (NSString*) string {
  
  NSMutableString* resultString = [NSMutableString string];
  
  if (self.tag.isConstracted) {
    [resultString appendString:[NSString stringWithFormat:@"▼%@\n",self.tag.data.hexString]];
    for (Tlv* tlv in self.array) {
      
      [resultString appendString:[NSString stringWithFormat:@" %@ %@", string,[tlv printTlvStructureWithOffsetString:@"   "]]];
    }
    return resultString;
  }
  
    return [NSString stringWithFormat:@"➞ %@ %@ \n", self.tag.data.hexString ,self.value.hexString];
  
}

-(NSString*)stringEncodeTlv {
  NSMutableString* resultString = [NSMutableString string];
  NSString* tagHexString = self.tag.data.hexString;
  
  [resultString appendString:tagHexString];
  
  uint lenght = self.lenght - self.tag.lenght - [self lenghtOfLenght];
  
  NSString* lenghtHexString = [NSData dataWithBytes:&(lenght) length:[self lenghtOfLenght]].hexString;
  [resultString appendString: lenghtHexString];

  if (self.primitive) {   

    [resultString appendString:self.value.hexString];
  } else {
    for (Tlv* tlv in self.array) {
      [resultString appendString:tlv.stringEncodeTlv];
    }
  }
  
  return resultString;
  
}

@end
