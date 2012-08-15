//
//  MainTableViewController.m
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

#import "MainTableViewController.h"
#import "FGPageInfo.h"

@interface MainTableViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation MainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Ensure the FGPagedTableViewController's data source and delegate are set to the current instance
	self.pagingDelegate = self;
	self.pagingDataSource = self;
	
	// Register a generic UITableViewCell with the UITableView
	if ([self.tableView respondsToSelector:@selector(registerClass:forCellReuseIdentifier:)]) {
		[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
	}
	
	// Create a simple simulated web-service to vend objects
	self.exampleService = [[ExamplePseudoService alloc] initWithTotalNumberOfResults:18 numberOfResultsPerPage:5];
	self.exampleService.simulatedLatency = 4.0;
	
	// Create a mutable array to store the objects retrieved from the example service
	self.items = [NSMutableArray array];
	
	// Setup a refresh control to clear and refresh the data from the web-service
	if ([self respondsToSelector:@selector(refreshControl)]) {
		self.refreshControl = [[UIRefreshControl alloc] init];
		[self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
	}
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	// Add initial status message
	[self showStatusCellWithType:FGStatusCellTypeCustom];
		
	self.statusCell.statusLabel.text = ([self respondsToSelector:@selector(refreshControl)]) ? @"Pull Down to Refresh" : @"Tap to Refresh";
	self.statusCell.detailsLabel.text = @"FGPagedTableViewController Example";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/**
 Returns the cell for the given index path that represents a paged result
 
 @param tableView A table-view object requesting the cell
 @param indexPath An index path locating a row in tableView
 */
- (UITableViewCell *)pagedTableView:(UITableView *)tableView resultCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	static NSString *reuseIdentifier = @"CellIdentifier";
	if ([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)]) {
		cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
	} else {
		cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
		}
	}
	
	cell.textLabel.text = self.items[indexPath.row];
	return cell;
}

/**
 Called when the paging cell is selected
 
 @param tableView A table-view object informing the delegate about the new paging row selection.
 @param indexPath An index path locating a row in tableView
 */
- (void)pagedTableView:(UITableView *)tableView didSelectPagingCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self requestNewPage];
}

/**
 Returns the total number of rows to be paged
 */
- (NSInteger)numberOfRowsInPagedData
{
	return self.items.count;
}

#pragma mark - Refresh

/**
 Requests a new page from the example service
 */
- (void)requestNewPage
{
	NSUInteger pageToRequest = (!self.pageInfo) ? 1 : ++self.pageInfo.currentPageNumber;
	
	[self.exampleService requestPage:pageToRequest completion:^(NSDictionary *pageDictionary) {

		NSArray *objects = pageDictionary[@"objects"];
		FGPageInfo *pageInfo = [[FGPageInfo alloc] initWithDictionary:pageDictionary];
		
		[objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			[self.items addObject:obj];
			[self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(self.items.count-1) inSection:FGPagedTableViewSectionResults]] withRowAnimation:UITableViewRowAnimationTop];
		}];

		self.pageInfo = pageInfo;
	}];
}

/**
 Called by the target/action setup on the UIRefreshControl (e.g. Pull-to-Refresh)
 */
- (void)refresh:(id)sender
{
	if ([self.exampleService isRequestActive]) {
		[self.refreshControl endRefreshing];
		return;
	}
	
	self.pageInfo = nil;
	[self removePagingCell];
	[self removeStatusCell];
	[self.items removeAllObjects];
	[self.tableView reloadData];
	if ([self respondsToSelector:@selector(refreshControl)]) {
		[self.refreshControl endRefreshing];
	}
	[self showStatusCellWithType:FGStatusCellTypeSearching];
	[self requestNewPage];
}

#pragma mark - UITableViewDelegate Methods (for iOS 5.x)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Must call super's implementation so that we are extending the method and not overriding.
	// This ensures that the paging delegate method is called when the paging cell is selected.
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	
	// Only call refresh if there is no refreshControl method up the responder chain (i.e. iOS 5.x)
	if (![self respondsToSelector:@selector(refreshControl)]) {
		if (indexPath.section == FGPagedTableViewSectionStatus) {
			[self refresh:self];
		}
	}
}

@end
