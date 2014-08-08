//
//  ViewController.m
//  FraseRandom
//
//  Created by Pablo García-Nieto Rodríguez  on 08/08/14.
//  Copyright (c) 2014 Pablo García-Nieto Rodríguez . All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+HexColors.h"
@interface ViewController ()

@end
NSMutableArray* questions;
@implementation ViewController

- (void)viewDidLoad
{
    NSLog(@"Load");
    self.navigationController.navigationBarHidden = YES;

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if ([savedData objectForKey:@"questions"] != nil) {
            questions = [[NSMutableArray alloc] initWithArray:[savedData objectForKey:@"questions"]];
            
        }
    }

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shuffle:(id)sender {
    NSString* chosen =self.label.text;
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [self.label.layer addAnimation:animation forKey:@"kCATransitionFade"];
    if(questions.count<2){
        self.label.text=@"Primero añade más frases :)";
        
    }else{
    while([self.label.text isEqualToString:chosen]){
        NSUInteger randomIndex = arc4random() % [questions count];
        chosen =questions[randomIndex];
    }
       
        
    self.label.text=chosen;
    NSArray  * colors = [NSArray arrayWithObjects:@"faafb2",@"4ceafd",@"dab0fd", @"fffba0", @"cde5fd", @"e8cffd", @"fde2a3",nil];
    UIColor *actual = self.view.layer.backgroundColor;
    NSUInteger randomColor = arc4random() % [colors count];
    NSString *color = [colors objectAtIndex:randomColor];
    UIColor* colorUI = [UIColor colorWithHexString:color];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.view.layer.backgroundColor = colorUI.CGColor;
    } completion:NULL];
    }

}
@end
