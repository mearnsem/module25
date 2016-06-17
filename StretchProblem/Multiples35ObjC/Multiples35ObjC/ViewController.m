//
//  ViewController.m
//  Multiples35ObjC
//
//  Created by Emily Mearns on 6/17/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fizzBuzz:100];
}

- (void)fizzBuzz:(int)num  {
    
    
    for(int a = 1; a <= num; a +=1) {
        
        if (a % 3 == 0 && a % 5 == 0) {
            NSLog(@"fizzBuzz");
        } else if (a % 3 == 0) {
            NSLog(@"fizz");
        } else if (a % 5 == 0) {
            NSLog(@"buzz");
        } else {
            NSLog(@"%d", a);
        }
        
        
    }
    
    
}




@end
