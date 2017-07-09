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
  self.inputHexString.text =
 @"e1 35 9f 1e  08 31 36 30    32 31 34 33  37 ef 12 df"
 @"0d 08 4d 30  30 30 2d 4d    50 49 df 7f  04 31 2d 32"
 @"32 ef 14 df  0d 0b 4d 30    30 30 2d 54  45 53 54 4f"
 @"53 df 7f 03  36 2d 35";
  self.outputHexString.text = @"";
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


-(IBAction) convertHexToTvlString {
  @try {
    self.outputHexString.text =  [HexStringTlvParser parseTlvFromHexString: self.inputHexString.text];
  } @catch (NSException *exception) {
    self.outputHexString.text = exception.description;
  }
}

@end
