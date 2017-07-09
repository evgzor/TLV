//
//  TLVParserTests.m
//  TLVParserTests
//
//  Created by Eugene Zorin on 08/07/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSData+HexString.h"
#import "Tlv.h"
#import "TlvDataParser.h"
#import "HexStringTlvParser.h"

@interface TLVParserTests : XCTestCase

@end

@implementation TLVParserTests

- (void)setUp {
  [super setUp];
}

- (void)tearDown {

  [super tearDown];
}

- (void)testHexToDataParser {
  NSString* hexStr =
 @"E1 35 9f 1e  08 31 36 30    32 31 34 33  37 ef 12 df"
 @"0d 08 4d 30  30 30 2d 4d    50 49 df 7f  04 31 2d 32"
 @"32 ef 14 df  0d 0b 4d 30    30 30 2d 54  45 53 54 4F"
  @"53 df 7f 03  36 2d 35";
  
  NSData* hexData = [NSData dataWithHexString:hexStr];
  TlvDataParser* parser = [[TlvDataParser alloc] init];
  
  Tlv* tlvParsed = [parser parseConsructedTlvData:hexData];
  NSString* dump = [tlvParsed printTlvStructureWithOffsetString:@""];
  
  NSLog(@"%@",dump);
  
  NSString* serializedString = tlvParsed.stringEncodeTlv;
  
  NSString *formatedHex = [[hexStr.lowercaseString componentsSeparatedByCharactersInSet:
                            [[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdef"]
                             invertedSet]]
                           componentsJoinedByString:@""];
  
  NSString* outputString = [HexStringTlvParser parseTlvFromHexString:hexStr];
  
  XCTAssertEqual(3, tlvParsed.array.count);
  XCTAssertEqual([formatedHex isEqualToString:serializedString], YES);
  XCTAssertEqual(outputString.length, 151);
  
  
  // This is an example of a functional test case.
  // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
  // This is an example of a performance test case.
  [self measureBlock:^{
    // Put the code you want to measure the time of here.
  }];
}
@end
