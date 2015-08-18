//
//  CYPCircularProgressView.m
//  Cyprus
//
//  Created by Joel Glanfield on 2015-08-17.
//  Copyright © 2015 Joel Glanfield. All rights reserved.
//

#import "JDGCircularProgressView.h"

@interface JDGCircularProgressView ()

@property (nonatomic, strong) CAShapeLayer *backgroundProgressLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation JDGCircularProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self createProgressLayer];
    }
    
    return self;
}

- (void)createProgressLayer {
    self.progressLayer = [CAShapeLayer layer];
    
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = M_PI * 2.0 + M_PI_2;
    CGPoint centerPoint = CGPointMake(CGRectGetWidth(self.frame)/2 , CGRectGetHeight(self.frame)/2);
    
    // layer for the progress circle to fill in
    self.backgroundProgressLayer = [CAShapeLayer layer];
    self.backgroundProgressLayer.path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:CGRectGetWidth(self.bounds) * 0.35 startAngle:startAngle endAngle:endAngle clockwise:YES].CGPath;
    self.backgroundProgressLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.backgroundProgressLayer.fillColor = nil;
    self.backgroundProgressLayer.strokeColor = [UIColor colorWithWhite:1.0 alpha:0.25].CGColor;
    self.backgroundProgressLayer.lineWidth = 4.0;
    self.backgroundProgressLayer.strokeStart = 0.0;
    self.backgroundProgressLayer.strokeEnd = 1.0;
    [self.layer addSublayer:self.backgroundProgressLayer];
    
    self.gradientLayer = [self gradientMaskWithTopColor:[UIColor whiteColor] bottomColor:[UIColor whiteColor]];
    
    self.progressLayer.path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:CGRectGetWidth(self.bounds) * 0.35 startAngle:startAngle endAngle:endAngle clockwise:YES].CGPath;
    self.progressLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.progressLayer.fillColor = nil;
    self.progressLayer.strokeColor = [UIColor blackColor].CGColor;
    self.progressLayer.lineWidth = 4.0;
    self.progressLayer.strokeStart = 0.0;
    self.progressLayer.strokeEnd = 0.0;
    
    self.gradientLayer.mask = self.progressLayer;
    [self.layer addSublayer:self.gradientLayer];
}

- (CAGradientLayer*)gradientMaskWithTopColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.locations = @[@0.0, @1.0];
    gradient.colors = @[(__bridge id)topColor.CGColor, (__bridge id)bottomColor.CGColor];
    
    return gradient;
}

- (void)animateProgressViewWithProgress:(CGFloat)currentProgress lastProgress:(CGFloat)lastProgress {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(lastProgress);
    animation.toValue = @(currentProgress);
    animation.duration = 0.5;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.progressLayer addAnimation:animation forKey:@"strokeEnd"];
}

- (void)animateProgressCompleteWithDuration:(CFTimeInterval)duration {
    [self.backgroundProgressLayer removeFromSuperlayer];
    
    CGFloat startAngle = M_PI_2;
    CGFloat endAngle = M_PI * 2.0 + M_PI_2;
    CGPoint centerPoint = CGPointMake(CGRectGetWidth(self.frame)/2 , CGRectGetHeight(self.frame)/2);
    CGFloat newRadius = CGRectGetWidth(self.bounds) * 0.45;
    CGFloat finalRadius = CGRectGetWidth(self.bounds) * 0.35;
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:newRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:finalRadius startAngle:startAngle endAngle:endAngle clockwise:YES];

    CAKeyframeAnimation* pathAnim = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    pathAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnim.values = @[(id)startPath.CGPath, (id)endPath.CGPath, (id)startPath.CGPath];
    
    CAAnimationGroup *anims = [CAAnimationGroup animation];
    anims.animations = @[pathAnim];
    anims.duration = duration;
    
    [self.progressLayer addAnimation:anims forKey:nil];
}

@end
