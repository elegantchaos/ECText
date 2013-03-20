// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECHTMLParser.h"

#import "ECDocumentStyles.h"

#if EC_PLATFORM_IOS
#import <CoreText/CoreText.h>
#endif

#pragma mark - Private Interface

@interface ECHTMLParser()

#pragma mark - Private Properties

@property (strong, nonatomic) NSRegularExpression* patternBold;
@property (strong, nonatomic) NSRegularExpression* patternEm;
@property (strong, nonatomic) NSRegularExpression* patternItalic;
@property (strong, nonatomic) NSRegularExpression* patternStrong;
@property (strong, nonatomic) NSRegularExpression* patternAnyTag;

#pragma mark - Private Methods

- (void)initialisePatterns;

@end

@implementation ECHTMLParser

#pragma mark - Properties

@synthesize patternBold = _patternBold;
@synthesize patternEm = _patternEm;
@synthesize patternItalic = _patternItalic;
@synthesize patternStrong = _patternStrong;
@synthesize patternAnyTag = _patternAnyTag;

#pragma mark - Debug Channels

ECDefineDebugChannel(ECHTMLChannel);

#pragma mark - Object Lifecycle

// --------------------------------------------------------------------------
//! Initialise with some styles.
// --------------------------------------------------------------------------

- (id)initWithStyles:(ECDocumentStyles *)stylesIn
{
    if ((self = [super initWithStyles:stylesIn]) != nil) 
    {
		[self initialisePatterns];
    }
	
    return self;
}

// --------------------------------------------------------------------------
//! Cleanup.
// --------------------------------------------------------------------------

- (void)dealloc 
{
	[_patternBold release];
	[_patternEm release];
	[_patternItalic release];
	[_patternStrong release];
    [_patternAnyTag release];

    [super dealloc];
}

#pragma mark - HTML

// --------------------------------------------------------------------------
//! Prepare expressions that we'll need.
// --------------------------------------------------------------------------

- (void)initialisePatterns
{
	NSError* error = nil;
	NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators;
	
	self.patternBold = [NSRegularExpression regularExpressionWithPattern:@"<b>(.*?)</b>" options:options error:&error];
    self.patternStrong = [NSRegularExpression regularExpressionWithPattern:@"<strong>(.*?)</strong>" options:options error:&error];
    self.patternItalic = [NSRegularExpression regularExpressionWithPattern:@"<i>(.*?)</i>" options:options error:&error];
    self.patternEm = [NSRegularExpression regularExpressionWithPattern:@"<em>(.*?)</em>" options:options error:&error];
    self.patternAnyTag = [NSRegularExpression regularExpressionWithPattern:@"<(.*?)>(.*?)</\\1>" options:options error:&error];
}

// --------------------------------------------------------------------------
//! Parse some html and return an attributed string.
// --------------------------------------------------------------------------

- (NSAttributedString*)attributedStringFromHTML:(NSString *)html
{
    NSMutableAttributedString* styled = [[NSMutableAttributedString alloc] initWithString:html attributes:self.attributesPlain];
    NSMatchingOptions options = 0;
	[styled replaceExpression:self.patternBold options:options atIndex:0 withIndex:1 attributes:self.attributesBold];
	[styled replaceExpression:self.patternStrong options:options atIndex:0 withIndex:1 attributes:self.attributesBold];
	[styled replaceExpression:self.patternItalic options:options atIndex:0 withIndex:1 attributes:self.attributesItalic];
	[styled replaceExpression:self.patternEm options:options atIndex:0 withIndex:1 attributes:self.attributesItalic];
	//	[styled replaceExpression:self.patternAnyTag options:options atIndex:0 withIndex:2 attributes:self.attributesPlain];

	[styled unescapeEntities];

	ECDebug(ECHTMLChannel, @"parsed html %@ into %@", html, styled);
    return [styled autorelease];
}

@end
