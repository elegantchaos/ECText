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

@property (nonatomic, retain) NSString* plainFont;
@property (nonatomic, retain) NSString* boldFont;
@property (nonatomic, retain) NSString* headingFont;
@property (nonatomic, retain) NSString* italicFont;

@property (nonatomic, assign) CGFloat plainSize;
@property (nonatomic, assign) CGFloat headingSize;

@property (nonatomic, assign) CGColorRef colour;
@property (nonatomic, assign) CGColorRef linkColour;


@end
