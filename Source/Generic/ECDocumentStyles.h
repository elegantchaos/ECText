// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class UIFont;

@interface ECDocumentStyles : NSObject

@property (strong, nonatomic) NSString* plainFont;
@property (strong, nonatomic) NSString* boldFont;
@property (strong, nonatomic) NSString* headingFont;
@property (strong, nonatomic) NSString* italicFont;

@property (assign, nonatomic) CGFloat plainSize;
@property (assign, nonatomic) CGFloat headingSize;

@property (assign, nonatomic) CGColorRef colour;
@property (assign, nonatomic) CGColorRef linkColour;


@end
