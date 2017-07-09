//
//  NSData+HexString.m
//  libsecurity_transform
//
//  Copyright (c) 2011 Apple, Inc. All rights reserved.
//

#import "NSData+HexString.h"

@implementation NSData (HexString)

+(instancetype)dataWithHexString:(NSString *)hex
{
  NSString *formatedHex = [[hex.lowercaseString componentsSeparatedByCharactersInSet:
                                     [[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdef"]
                                      invertedSet]]
                                    componentsJoinedByString:@""];
  
  
  char buf[3];
  buf[2] = '\0';
  if ([formatedHex length] % 2 != 0) {
     [NSException raise:@"Bad Input data" format:@"Hex strings should have an even number of digits (%@)",hex];
    return nil;
  }
  
  unsigned char *bytes = malloc([formatedHex length]/2);
  unsigned char *bp = bytes;
  for (CFIndex i = 0; i < [formatedHex length]; i += 2) {
    buf[0] = [formatedHex characterAtIndex:i];
    buf[1] = [formatedHex characterAtIndex:i+1];
    char *b2 = NULL;
    *bp++ = strtol(buf, &b2, 16);
    if (b2 != buf + 2) {
      [NSException raise: @"Bad data" format: @"String should be all hex digits: %@ (bad digit around %ld)", formatedHex, i];
    }
  }
  NSData* result = [NSData dataWithBytesNoCopy:bytes length:[formatedHex length]/2 freeWhenDone:YES];
  return result;
}

- (NSString*) hexString {
  NSMutableString* string = [NSMutableString string];
  uint8_t const *bytes = self.bytes;
  for (NSUInteger i = 0; i< self.length; i++) {
    [string appendFormat:@"%02x", ((uint8_t)bytes[i])];
  }
  
  return string;
}


@end
