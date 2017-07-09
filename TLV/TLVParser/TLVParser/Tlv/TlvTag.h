//
//  TlvTag.h
//  TVLParser
//
//  Created by Eugene Zorin on 06/07/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Tlv tag class
 */
@interface TlvTag : NSObject

/**
 check constructed Tlv tag
 */
@property (readonly) BOOL isConstracted;
/**
 data for tag
 */
@property (copy, nonatomic) NSData* data;
/**
 lenght of tag
 */
@property (nonatomic) uint lenght;

/**
 init tlv tag

 @param data for extract tag
 @param offset offset
 @param lenght tag lenght
 @return TlvTag object
 */
- (instancetype) init: (NSData*) data offset: (uint) offset lenght: (uint) lenght;


@end
