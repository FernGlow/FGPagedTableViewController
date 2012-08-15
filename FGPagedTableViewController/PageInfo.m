//
//  PageInfo.m
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
