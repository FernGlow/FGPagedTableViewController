//
//  ExamplePseudoService.m
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

#import "ExamplePseudoService.h"
#import "FGPageInfo.h"

@interface ExamplePseudoService ()
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, assign) NSInteger resultsPerPage;
@end

@implementation ExamplePseudoService

- (id)initWithTotalNumberOfResults:(NSUInteger)totalNumberOfResults numberOfResultsPerPage:(NSUInteger)numberOfResultsPerPage
{
	self = [super init];
	if (self) {
		_simulatedLatency = 2.0;
		_resultsPerPage = numberOfResultsPerPage;
		_objects = [@[] mutableCopy];
		for (NSInteger i = 1; i <= totalNumberOfResults; i++) {
			[_objects addObject:[NSString stringWithFormat:@"Object #%d", i]];
		}
	}
	return self;
}

- (NSDictionary *)pageDictionaryForPageNumber:(NSInteger)currentPage
{
	NSInteger totalPages = (NSInteger)(((double)self.objects.count / (double)self.resultsPerPage) + 0.9999);			// intentional precision loss
	NSInteger resultsRemainder = self.objects.count % self.resultsPerPage;
	NSInteger numberOfResultsInCurrentPage = (currentPage == totalPages && resultsRemainder > 0) ? resultsRemainder : self.resultsPerPage;
	
	NSUInteger firstObjectIndex = (currentPage-1) * self.resultsPerPage;
	NSUInteger lastObjectIndex = (currentPage < totalPages) ? (currentPage * self.resultsPerPage) - 1 : self.objects.count - 1;
	
	NSMutableArray *requestedObjects = [@[] mutableCopy];
	for (NSInteger i = firstObjectIndex; i <= lastObjectIndex; i++) {
		id requestedObject = [self.objects objectAtIndex:i];
		[requestedObjects addObject:requestedObject];
	}

	NSMutableDictionary *requestDictionary = [@{} mutableCopy];
	[requestDictionary setObject:requestedObjects forKey:@"objects"];
	[requestDictionary setObject:@(self.objects.count) forKey:FGPageInfoNumberOfResults];
	[requestDictionary setObject:@(totalPages) forKey:FGPageInfoNumberOfPages];
	[requestDictionary setObject:@(currentPage) forKey:FGPageInfoCurrentPageNumber];
	[requestDictionary setObject:@(numberOfResultsInCurrentPage) forKey:FGPageInfoNumberOfResultsInCurrentPage];
	
	return requestDictionary;
}

- (void)requestPage:(NSUInteger)pageNumber completion:(void (^)(NSDictionary *pageDictionary))completion
{
	int64_t delayInSeconds = self.simulatedLatency;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		if (completion) completion([self pageDictionaryForPageNumber:pageNumber]);
	});
}

@end
