//
//  MainTableViewController.m
//  FGPagedTableViewController
//
//  Created by Andrew Michaelson on 7/16/12.
//  Copyright (c) 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//

#import "MainTableViewController.h"
#import "PageInfo.h"

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
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
	
	// Create a simple simulated web-service to vend objects
	self.exampleService = [[ExamplePseudoService alloc] initWithTotalNumberOfResults:18 numberOfResultsPerPage:5];
	self.exampleService.simulatedLatency = 5.0;
	
	// Create a mutable array to store the objects retrieved from the example service
	self.items = [NSMutableArray array];
	
	// Setup a refresh control to clear and refresh the data from the web-service
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
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
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
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
		PageInfo *pageInfo = [[PageInfo alloc] initWithDictionary:pageDictionary];
		
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
	self.pageInfo = nil;
	[self removePagingCell];
	[self removeStatusCell];
	[self.items removeAllObjects];
	[self.tableView reloadData];
	[self.refreshControl endRefreshing];
	[self showStatusCellWithType:FGStatusCellTypeSearching];
	[self requestNewPage];
}

@end
