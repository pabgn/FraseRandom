//
//  ViewController.h
//  FraseRandom
//
//  Created by Pablo García-Nieto Rodríguez  on 08/08/14.
//  Copyright (c) 2014 Pablo García-Nieto Rodríguez . All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController : UIViewController
- (IBAction)shuffle:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
