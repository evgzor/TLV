//
//  TlvTag.m
//  TVLParser
//
//  Created by Eugene Zorin on 06/07/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "TlvTag.h"

@implementation TlvTag

-(instancetype)init:(NSData *)data offset:(uint)offset lenght:(uint)lenght {
  
  self = [super init];
  
  if (self) {
    _data = [data subdataWithRange:NSMakeRange(offset, lenght)];
    _lenght = lenght;
  }
  return self;
}

-(uint)lenght {
  return _lenght;
}

-(BOOL)isConstracted {
  uint8_t *bytes = (uint8_t*) _data.bytes;
  //sixth byte for nested TLV
  return (bytes[0] & 0b00100000) != 0;
}
@end
