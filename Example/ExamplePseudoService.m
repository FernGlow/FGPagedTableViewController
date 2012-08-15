//
//  ExamplePseudoService.m
//  FGPagedTableViewController
//
//  Created by Andrew Michaelson on 8/13/12.
//  Copyright (c) 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//

#import "ExamplePseudoService.h"
#import "PageInfo.h"

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
	[requestDictionary setObject:@(self.objects.count) forKey:kPageInfoNumberOfResults];
	[requestDictionary setObject:@(totalPages) forKey:kPageInfoNumberOfPages];
	[requestDictionary setObject:@(currentPage) forKey:kPageInfoCurrentPageNumber];
	[requestDictionary setObject:@(numberOfResultsInCurrentPage) forKey:kPageInfoNumberOfResultsInCurrentPage];
	
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
