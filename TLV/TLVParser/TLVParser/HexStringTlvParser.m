//
//  HexStringTvlParser.m
//  TVLParser
//
//  Created by Eugene Zorin on 08/07/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "HexStringTlvParser.h"
#import "NSData+HexString.h"
#import "Tlv.h"
#import "TlvDataParser.h"


@implementation HexStringTlvParser

+ (NSString*)parseTlvFromHexString:(NSString*) hexSting {
  @try {
    NSData* hexData = [NSData dataWithHexString:hexSting];
    if (hexData.length) {
      TlvDataParser* parser = [[TlvDataParser alloc] init];
      
      Tlv* tlvParsed = [parser parseConsructedTlvData:hexData];
      return [tlvParsed printTlvStructureWithOffsetString:@""];
    }
  } @catch (NSException *exception) {
    [NSException raise:@"Bad Parsing" format:@"%@",exception.reason];
  }
  
  return @"Wrong data";
}
@end
