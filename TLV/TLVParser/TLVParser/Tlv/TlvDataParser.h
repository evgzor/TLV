//
//  TlvDataParser.h
//  TVLParser
//
//  Created by Eugene Zorin on 06/07/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tlv.h"
/**
 Parser Tlv string data class
 */
@interface TlvDataParser : NSObject

/**
 Parse constructed Tlv

 @param data parse data
 @return Tlv parsed object
 */
-(Tlv*) parseConsructedTlvData: (NSData*) data;

@end
