//
//  PageInfo.h
//  FGPagedTableViewController
//
//  Created by Andrew Michaelson on 5/12/12.
//  Copyright (c) 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString *kPageInfoNumberOfResults					= @"numberOfResults";				// required
static const NSString *kPageInfoNumberOfPages					= @"numberOfPages";					// required
static const NSString *kPageInfoCurrentPageNumber				= @"currentPageNumber";				// required
static const NSString *kPageInfoNumberOfResultsInCurrentPage	= @"numberOfResultsInCurrentPage";	// unused

@interface PageInfo : NSObject

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
