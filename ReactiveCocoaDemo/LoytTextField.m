//
//  LoytTextField.m
//  ReactiveCocoaDemo
//
//  Created by 梁兴胜 on 16/8/25.
//  Copyright © 2016年 nercita. All rights reserved.
//

#import "LoytTextField.h"

@implementation LoytTextField

- (CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 40, 0);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds;{
    
    return CGRectInset(bounds, 40, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds;{
    
    return CGRectInset(bounds, 40, 0);
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.820 alpha:1.000].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
}
@end
