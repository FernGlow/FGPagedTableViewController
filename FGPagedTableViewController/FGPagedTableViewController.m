//
//  FGPagedTableViewController.m
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

#import "FGPagedTableViewController.h"

@interface FGPagedTableViewController ()
@property (nonatomic, strong) FGStatusTableViewCell *statusCell;
@property (nonatomic, strong) FGPagingTableViewCell *pagingCell;
@end

@implementation FGPagedTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.tableView registerNib:[UINib nibWithNibName:@"FGStatusTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FGStatusTableViewCell"];
	[self.tableView registerNib:[UINib nibWithNibName:@"FGPagingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FGPagingTableViewCell"];
	self.statusCell = [self statusCellWithType:FGStatusCellTypeNone];
	self.pagingCell = [self pagingCellWithType:FGPagingCellTypeNone];
	self.tableView.rowHeight = 78.0f;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Paging

- (void)updatePagingIfNeeded
{
	BOOL shouldAddPagingCell = (self.pageInfo.currentPageNumber < self.pageInfo.numberOfPages) && self.pagingCell.cellType == FGPagingCellTypeNone;
	BOOL shouldReloadPagingCell = (self.pageInfo.currentPageNumber < self.pageInfo.numberOfPages) && self.pagingCell.cellType != FGPagingCellTypeNone;
	BOOL shouldDeletePagingCell = (self.pageInfo.currentPageNumber == self.pageInfo.numberOfPages) && self.pagingCell.cellType != FGPagingCellTypeNone;
	
	if (shouldAddPagingCell) {
		[self showPagingCellWithType:FGPagingCellTypeContinue];
	} else if (shouldReloadPagingCell) {
		[self reloadPagingCell];
	} else if (shouldDeletePagingCell) {
		[self removePagingCell];
	}
}

- (void)setPageInfo:(FGPageInfo *)pageInfo
{
	_pageInfo = pageInfo;
	[self updateStatusIfNeeded];
	[self updatePagingIfNeeded];
}

/*
 Status Cell
 */
#pragma mark - Status Cell

- (void)updateStatusIfNeeded
{
	BOOL shouldDeleteStatusCell = self.statusCell.cellType != FGStatusCellTypeNone;
	if (shouldDeleteStatusCell) {
		[self removeStatusCell];
	}
}

- (void)showStatusCellWithType:(FGStatusCellType)type
{
	[self removeStatusCell];
	self.statusCell.cellType = type;
	[self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:FGPagedTableViewSectionStatus]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)removeStatusCell
{
	BOOL shouldRemoveStatusCellSection = self.statusCell.cellType != FGStatusCellTypeNone;
	if (shouldRemoveStatusCellSection) {
		self.statusCell.cellType = FGStatusCellTypeNone;
		[self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:FGPagedTableViewSectionStatus]] withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

/*
 Paging Cell
 */
#pragma mark - Paging Cell

- (void)showPagingCellWithType:(FGPagingCellType)type
{
	self.pagingCell.cellType = type;
	[self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:FGPagedTableViewSectionPaging]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)removePagingCell
{
	BOOL shouldRemovePagingCellSection = self.pagingCell.cellType != FGPagingCellTypeNone;
	if (shouldRemovePagingCellSection) {
		self.pagingCell.cellType = FGPagingCellTypeNone;
		[self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:FGPagedTableViewSectionPaging]] withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

- (void)setPagingCellWithType:(FGPagingCellType)type
{
	self.pagingCell.cellType = type;
}

- (void)reloadPagingCell
{
    BOOL shouldReload = (self.pageInfo.currentPageNumber < self.pageInfo.numberOfPages);
	if (shouldReload) {
		self.pagingCell.cellType = FGPagingCellTypeContinue;
	}
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;	// status, results, paging
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == FGPagedTableViewSectionStatus) {
		BOOL statusCellExists = (self.statusCell.cellType != FGStatusCellTypeNone);
		return (statusCellExists) ? 1 : 0;
	} else if (section == FGPagedTableViewSectionPaging) {
		BOOL pagingCellExists = (self.pagingCell.cellType != FGPagingCellTypeNone);
		return (pagingCellExists) ? 1 : 0;
	} else if (section == FGPagedTableViewSectionResults) {
		return [self numberOfResultsInDataSource];
	}
	
    return 0;
}

- (FGStatusTableViewCell *)statusCellWithType:(FGStatusCellType)statusCellType
{
	FGStatusTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FGStatusTableViewCell"];
	cell.cellType = statusCellType;
	self.statusCell = cell;
	return cell;
}

- (FGPagingTableViewCell *)pagingCellWithType:(FGPagingCellType)pagedCellType
{
	FGPagingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FGPagingTableViewCell"];
	cell.cellType = pagedCellType;
	self.pagingCell = cell;
	return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == FGPagedTableViewSectionStatus) {
		id cell = [self statusCellWithType:self.statusCell.cellType];
		return cell;
	} else if (indexPath.section == FGPagedTableViewSectionPaging) {
		FGStatusTableViewCell *cell = (FGStatusTableViewCell *)[self pagingCellWithType:self.pagingCell.cellType];
		
		// Continue
		if (cell.cellType == FGPagingCellTypeContinue || cell.cellType == FGPagingCellTypeRetrieving) {
			NSInteger numberOfRemainingResultsOnServer = self.pageInfo.numberOfResults - [self numberOfResultsInDataSource];
			cell.detailsLabel.text = [NSString stringWithFormat:@"%i more results on server", numberOfRemainingResultsOnServer];
		}
		return cell;
	} else if (indexPath.section == FGPagedTableViewSectionResults) {
		if ([self.pagingDataSource respondsToSelector:@selector(pagedTableView:resultCellForRowAtIndexPath:)]) {
			return [self.pagingDataSource pagedTableView:tableView resultCellForRowAtIndexPath:indexPath];
		}
	}

	return nil;
}

- (NSInteger)numberOfResultsInDataSource
{
	if ([self.pagingDataSource respondsToSelector:@selector(numberOfRowsInPagedData)]) {
		return [self.pagingDataSource numberOfRowsInPagedData];
	}
	
	return 0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	BOOL isPagingCell = [tableView cellForRowAtIndexPath:indexPath].tag == FGPagingCellTypeContinue;
	if (isPagingCell && [self.pagingDelegate respondsToSelector:@selector(pagedTableView:didSelectPagingCellForRowAtIndexPath:)]) {
		[self setPagingCellWithType:FGPagingCellTypeRetrieving];
		[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:FGPagedTableViewSectionPaging]] withRowAnimation:UITableViewRowAnimationAutomatic];
		[self.pagingDelegate pagedTableView:tableView didSelectPagingCellForRowAtIndexPath:indexPath];
	}
}

@end
