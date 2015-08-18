//
//  CYPCircularProgressView.h
//  Cyprus
//
//  Created by Joel Glanfield on 2015-08-17.
//  Copyright © 2015 Joel Glanfield. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDGCircularProgressView : UIView

- (void)animateProgressCompleteWithDuration:(CFTimeInterval)duration;
- (void)animateProgressViewWithProgress:(CGFloat)currentProgress lastProgress:(CGFloat)lastProgress;

@end
