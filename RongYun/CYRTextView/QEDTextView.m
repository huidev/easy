//
//  QEDTextView.m
//  CYRTextViewExample
//
//  Created by Illya Busigin on 1/10/14.
//  Copyright (c) 2014 Cyrillian, Inc. All rights reserved.
//

#import "QEDTextView.h"

#import <CoreText/CoreText.h>


@implementation QEDTextView

#pragma mark - Initialization & Setup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self commonSetup];
    }
    
    return self;
}

- (void)commonSetup
{
    _defaultFont = [UIFont systemFontOfSize:14.0f];
    _boldFont = [UIFont boldSystemFontOfSize:14.0f];
    _italicFont = [UIFont fontWithName:@"HelveticaNeue-Oblique" size:14.0f];
    
    self.font = _defaultFont;
    self.textColor = [UIColor blackColor];
    
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(defaultFont)) options:NSKeyValueObservingOptionNew context:0];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(boldFont)) options:NSKeyValueObservingOptionNew context:0];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(italicFont)) options:NSKeyValueObservingOptionNew context:0];
    
    if (_italicFont == nil && ([UIFontDescriptor class] != nil))
    {
        // This works around a bug in 7.0.3 where HelveticaNeue-Italic is not present as a UIFont option
        _italicFont = (__bridge_transfer UIFont*)CTFontCreateWithName(CFSTR("HelveticaNeue-Italic"), 14.0f, NULL);
    }
    
    self.tokens = [self solverTokens];
}


- (NSArray *)solverTokens
{
    NSArray *solverTokens =  @[
                               
                               [CYRToken tokenWithName:@"hex_1"
                                                expression:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
                                                attributes:@{
                                                             NSForegroundColorAttributeName : [UIColor blueColor]
                                                             }],
                               
                               
                               
                               
                               
                               [CYRToken tokenWithName:@"chart_parameters"
                                                expression:@"#[\\u4e00-\\u9fa5\\w\\-]*#"
                                                attributes:@{
                                                             NSForegroundColorAttributeName : [UIColor blueColor],
                                                             }],
                               [CYRToken tokenWithName:@"comment"
                                                expression:@"@[\\u4e00-\\u9fa5\\w\\-]+"
                                                attributes:@{
                                                             NSForegroundColorAttributeName : [UIColor blueColor],
                                                             NSFontAttributeName : self.italicFont
                                                             }]
                               ];
    
    return solverTokens;
}


#pragma mark - Cleanup

- (void)dealloc
{
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(defaultFont))];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(boldFont))];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(italicFont))];
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(defaultFont))] ||
        [keyPath isEqualToString:NSStringFromSelector(@selector(boldFont))] ||
        [keyPath isEqualToString:NSStringFromSelector(@selector(italicFont))])
    {
        // Reset the tokens, this will clear any existing formatting
        self.tokens = [self solverTokens];
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - Overrides

- (void)setDefaultFont:(UIFont *)defaultFont
{
    _defaultFont = defaultFont;
    self.font = defaultFont;
}

@end
