//
//  Tlv.h
//  TVLParser
//
//  Created by Eugene Zorin on 06/07/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TlvTag.h"

/**
 Tag Lenght Value class
 */
@interface Tlv : NSObject

/**
 Tlv Tag
 */
@property (copy, nonatomic, readonly) TlvTag* tag;
/**
 Tlv value
 */
@property (copy, nonatomic, readonly) NSData* value;
/**
 Constructed Nested Tlv list
 */
@property (copy, nonatomic, readonly) NSArray* array;
/**
 Checks 6-th byte for constructrd Tlv
 */
@property (nonatomic, readonly) BOOL constracted;
/**
 Check is not contain array
 */
@property (nonatomic, readonly) BOOL primitive;

/**
 Tlv lenght in bytes
 */
@property (nonatomic, readonly) uint lenght;

/**
 Init Tlv with primitive not constructed

 @param tag tag tlv
 @param value primitive value
 @return tlv object
 */
-(instancetype) init: (TlvTag*)tag value: (NSData*) value;
/**
 Init constructed Tlv

 @param tag Tlv tag
 @param array list nested Tlv
 @return Tlv object
 */
-(instancetype) init: (TlvTag*) tag array:(NSArray*) array;

/**
 Print Dump Tlv

 @param string main offset of element
 @return dump string
 */
-(NSString *)printTlvStructureWithOffsetString: (NSString*) string;

/**
 Seriliaze Tlv class in string

 @return hex string
 */
-(NSString*)stringEncodeTlv;


@end
