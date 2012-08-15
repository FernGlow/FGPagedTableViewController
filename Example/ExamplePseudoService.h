//
//  ExamplePseudoService.h
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


/**
 Returns whether or not there is a currently active request (readonly)
 */
@property (nonatomic, assign, readonly, getter = isRequestActive) BOOL requestActive;

@end
