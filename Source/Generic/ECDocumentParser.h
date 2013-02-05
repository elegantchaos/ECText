// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECDocumentStyles;

extern NSString *const ECDocumentLinkKey;

@interface ECDocumentParser : NSObject

#pragma mark - Public Properties

@property (strong, nonatomic) ECDocumentStyles* styles;
@property (strong, nonatomic) NSDictionary* attributesBold;
@property (strong, nonatomic) NSDictionary* attributesItalic;
@property (strong, nonatomic) NSDictionary* attributesPlain;
@property (strong, nonatomic) NSDictionary* attributesLink;

#pragma mark - Public Methods

- (id)initWithStyles:(ECDocumentStyles*)styles;
- (void)initialiseAttributes;

@end
