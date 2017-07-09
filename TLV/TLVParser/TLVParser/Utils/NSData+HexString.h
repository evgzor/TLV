//
//  NSData+NSData_HexString.h
//  TVLParser
//
//  Created by Eugene Zorin on 05/07/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HexString)
/**
 Convert and check data for NSdata string

 @param hex input hex not formated string
 @return NSData object
 */
+(instancetype)dataWithHexString:(NSString *)hex;

/**
 convert to hex string

 @return string in hex representation
 */
- (NSString*) hexString;

@end
