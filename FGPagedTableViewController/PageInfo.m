//
//  PageInfo.m
//  FGPagedTableViewController
//
//  Created by Andrew Michaelson on 5/12/12.
//  Copyright (c) 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//

#import "PageInfo.h"

@implementation PageInfo

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	if (self) {
		self.numberOfResults = [dict[kPageInfoNumberOfResults] integerValue];
		self.numberOfPages = [dict[kPageInfoNumberOfPages] integerValue];
		self.currentPageNumber = [dict[kPageInfoCurrentPageNumber] integerValue];
		self.numberOfResultsInCurrentPage = [dict[kPageInfoNumberOfResultsInCurrentPage] integerValue];
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"\n\nnumberOfResults: %d\nnumberOfPages: %d\ncurrentPageNumber: %d\nnumberOfResultsInCurrentPage: %d\n\n", _numberOfResults, _numberOfPages, _currentPageNumber, _numberOfResultsInCurrentPage];
}

@end
