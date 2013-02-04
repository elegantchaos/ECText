// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDocumentParser.h"
#import "ECDocumentStyles.h"

#if EC_PLATFORM_IOS
#import <CoreText/CoreText.h>
#endif

@implementation ECDocumentParser

#pragma mark - Constants

NSString *const ECDocumentLinkKey = @"ECDocumentLink";

#pragma mark - Properties

@synthesize attributesBold;
@synthesize attributesItalic;
@synthesize attributesLink;
@synthesize attributesPlain;
@synthesize styles;

#pragma mark - Object Lifecycle

// --------------------------------------------------------------------------
//! Initialise with some styles.
// --------------------------------------------------------------------------

- (id)initWithStyles:(ECDocumentStyles *)stylesIn
{
    if ((self = [super init]) != nil) 
    {
        self.styles = stylesIn;
		[self initialiseAttributes];
    }
	
    return self;
}

// --------------------------------------------------------------------------
//! Cleanup.
// --------------------------------------------------------------------------

- (void)dealloc 
{
	[attributesBold release];
	[attributesItalic release];
    [attributesLink release];
	[attributesPlain release];
    [styles release];
    
    [super dealloc];
}

#pragma mark - Initialisation

// --------------------------------------------------------------------------
//! Set up some styles we'll need.
// --------------------------------------------------------------------------

- (void)initialiseAttributes
{
#if EC_PLATFORM_IOS
	// TODO: this stuff is iOS 5 or later; not sure if we need to fallback to the core text version for earlier systems (for use with our own styled text field)

	self.attributesPlain = @{
		UITextAttributeFont: [UIFont fontWithName:styles.plainFont size:styles.plainSize],
		UITextAttributeTextColor: [UIColor colorWithCGColor:styles.colour]
		};

	self.attributesBold = @{
						  UITextAttributeFont: [UIFont fontWithName:styles.boldFont size:styles.plainSize],
		};

	self.attributesItalic = @{
						  UITextAttributeFont: [UIFont fontWithName:styles.italicFont size:styles.plainSize],
		};

	self.attributesLink = @{
		ECDocumentLinkKey : @"^2",
		 UITextAttributeTextColor: [UIColor colorWithCGColor:styles.linkColour]
		 };

#else
    CTFontRef boldFont = CTFontCreateWithName((CFStringRef)styles.boldFont, styles.plainSize, NULL);
    CTFontRef italicFont = CTFontCreateWithName((CFStringRef)styles.italicFont, styles.plainSize, NULL);
	CTFontRef plainFont = CTFontCreateWithName((CFStringRef)styles.plainFont, styles.plainSize, NULL);
    
    self.attributesPlain = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) plainFont, (id) kCTFontAttributeName,
     (id) styles.colour, (id)kCTForegroundColorAttributeName,
     nil
     ];
    
    self.attributesBold = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) boldFont, (id) kCTFontAttributeName,
     nil
     ];
	
	self.attributesItalic = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) italicFont, (id) kCTFontAttributeName,
     nil
     ];

    self.attributesLink = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) styles.linkColour, (id)kCTForegroundColorAttributeName,
     @"^2", ECDocumentLinkKey,
     nil
     ];

    CFRelease(boldFont);
    CFRelease(italicFont);
	CFRelease(plainFont);
#endif
}

@end
