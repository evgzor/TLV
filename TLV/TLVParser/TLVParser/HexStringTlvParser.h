//
//  HexStringTvlParser.h
//  TVLParser
//
//  Created by Eugene Zorin on 08/07/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HexStringTlvParser : NSObject

/**
 Parse Tlv hex String

 @param hexSting input string
 @return string representation of Tlv structure
 */
+ (NSString*)parseTlvFromHexString:(NSString*) hexSting;

@end
