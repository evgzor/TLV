//
//  ViewController.m
//  TLV-Example
//
//  Created by Eugene Zorin on 08/07/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "ViewController.h"

@import TLVParser;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *inputHexString;
@property (weak, nonatomic) IBOutlet UITextView *outputHexString;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.inputHexString.backgroundColor = [UIColor lightGrayColor];
  
  self.inputHexString.text =
 @"e1 35 9f 1e  08 31 36 30    32 31 34 33  37 ef 12 df"
 @"0d 08 4d 30  30 30 2d 4d    50 49 df 7f  04 31 2d 32"
 @"32 ef 14 df  0d 0b 4d 30    30 30 2d 54  45 53 54 4f"
 @"53 df 7f 03  36 2d 35";
  self.outputHexString.text = @"";
  
  self.outputHexString.layer.borderWidth = 0.1;
  self.outputHexString.layer.borderColor = [UIColor blackColor].CGColor;
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


-(IBAction) convertHexToTvlString {
  dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
  @try {
      NSString* parsedTlvStructure = @"";
      parsedTlvStructure = [HexStringTlvParser parseTlvFromHexString: self.inputHexString.text];
      
      dispatch_async( dispatch_get_main_queue(), ^{
        self.outputHexString.backgroundColor = [UIColor greenColor];
        self.outputHexString.text = parsedTlvStructure;
      });
    
  } @catch (NSException *exception) {
    dispatch_async( dispatch_get_main_queue(), ^{
      self.outputHexString.text = exception.description;
      self.outputHexString.backgroundColor = [UIColor redColor];
      });
  }
     });
}

@end
