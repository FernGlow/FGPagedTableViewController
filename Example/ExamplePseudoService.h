//
//  ExamplePseudoService.h
//  FGPagedTableViewController
//
//  Created by Andrew Michaelson on 8/13/12.
//  Copyright (c) 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamplePseudoService : NSObject

/**
 @name Adjusting the Simulated Latency of the Service
 */

/**
 Simulated latency (round-trip) in seconds
 
 The default simulated latency is 2.0 seconds
 */
@property (nonatomic, assign) NSUInteger simulatedLatency;


/**
 @name Initializing the Service
 */

/**
 Initialize the service
 @param totalNumberOfResults The total number of results returned by the service
 @param numberOfResultsPerPage The number of results contained in each page returned by the service
 */
- (id)initWithTotalNumberOfResults:(NSUInteger)totalNumberOfResults numberOfResultsPerPage:(NSUInteger)numberOfResultsPerPage;

/**
 @name Requesting Data from the Service
 */

/**
 Request a page from the service
 @param pageNumber The page number of results to return
 @param completion A block to execute when the page is returned
 */
- (void)requestPage:(NSUInteger)pageNumber completion:(void (^)(NSDictionary *pageDictionary))completion;

@end
