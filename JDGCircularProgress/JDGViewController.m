//
//  ViewController.m
//  JDGCircularProgress
//
//  Created by Joel Glanfield on 2015-08-17.
//  Copyright (c) 2015 Joel Glanfield. All rights reserved.
//

#import "JDGViewController.h"
#import "JDGCircularProgressView.h"

@interface JDGViewController ()

@property (strong, nonatomic) JDGCircularProgressView *progressView;

@end

@implementation JDGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self createScreenDetectProgressView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.progressView animateProgressViewWithProgress:1.0 lastProgress:0.0];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.progressView animateProgressCompleteWithDuration:0.5];
    });
}

- (void)createScreenDetectProgressView {
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    CGRect parentFrame = self.view.frame;
    CGFloat side = parentFrame.size.width * 0.2;
    CGRect progressFrame = CGRectMake((parentFrame.size.width - side) * 0.5,
                                      (parentFrame.size.height - side) * 0.5,
                                      side,
                                      side);
    self.progressView = [[JDGCircularProgressView alloc] initWithFrame:progressFrame];
    [self.view addSubview:self.progressView];
}

@end
