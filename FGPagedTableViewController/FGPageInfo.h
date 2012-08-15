//
//  PageInfo.h
//  FGPagedTableViewController
//
//  Copyright (c) 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <Foundation/Foundation.h>

static const NSString *FGPageInfoNumberOfResults				= @"numberOfResults";				// required
static const NSString *FGPageInfoNumberOfPages					= @"numberOfPages";					// required
static const NSString *FGPageInfoCurrentPageNumber				= @"currentPageNumber";				// required
static const NSString *FGPageInfoNumberOfResultsInCurrentPage	= @"numberOfResultsInCurrentPage";	// unused

@interface FGPageInfo : NSObject

/** @name Initializing the PageInfo object */

/**
 The total number of results to be paged through
 */
@property (nonatomic, assign) NSInteger numberOfResults;


/**
 The total number of pages to be paged through
 */
@property (nonatomic, assign) NSInteger numberOfPages;


/**
 The current page
 */
@property (nonatomic, assign) NSInteger currentPageNumber;


/**
 The total number of results in the current page
 @warning This property is currently unused and will be ignored.
 */
@property (nonatomic, assign) NSInteger numberOfResultsInCurrentPage;


/**
 Initialize the PageInfo object from a dictionary
 @param dict The dictionary containing the initialization data
 */
- (id)initWithDictionary:(NSDictionary *)dict;

@end
