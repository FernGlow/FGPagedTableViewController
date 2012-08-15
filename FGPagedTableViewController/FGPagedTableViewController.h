//
//  FGPagedTableViewController.h
//  FGPagedTableViewController
//
//  Created by Andrew Michaelson on 5/10/12.
//  Copyright (c) 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGStatusTableViewCell.h"
#import "FGPagingTableViewCell.h"
#import "PageInfo.h"

@class FGPagedTableViewControllerDataSource;

typedef enum : NSInteger {
	FGPagedTableViewSectionStatus = 0,
	FGPagedTableViewSectionResults = 1,
	FGPagedTableViewSectionPaging = 2
} FGPagedTableViewSection;

@protocol FGPagedTableViewControllerDelegate <NSObject>
@required
/**
 Tells the paging delegate that the specified paging row is now selected.
 
 @param tableView A table-view object informing the delegate about the new paging row selection.
 @param indexPath An index path locating a row in tableView
 */
- (void)pagedTableView:(UITableView *)tableView didSelectPagingCellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol FGPagedTableViewControllerDataSource <UITableViewDataSource>
@required

/**
 Asks the data source to return the result cell for the given row.
 
 @param tableView A table-view object requesting the cell
 @param indexPath An index path locating a row in tableView
 */
- (UITableViewCell *)pagedTableView:(UITableView *)tableView resultCellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Asks the data source to return the number of rows in the data to be paged.
 */
- (NSInteger)numberOfRowsInPagedData;
@end

@interface FGPagedTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

/** @name Managing the Delegate and the Data Source */

/**
 The object that acts as the delegate of the receiving table view controller.
 @see FGPagedTableViewControllerDelegate
 */
@property (nonatomic, weak) id<FGPagedTableViewControllerDelegate>pagingDelegate;

/**
 The object that acts as the data source of the receiving table view controller.
 @see FGPagedTableViewControllerDataSource
 */
@property (nonatomic, weak) id<FGPagedTableViewControllerDataSource>pagingDataSource;

/** @name Managing the Paging of the Table View */

/**
 Object that encapsulates the paging data.
 
 This object should be updated every time data is added or removed from the data source.

 @see PageInfo
 */
@property (nonatomic, strong) PageInfo *pageInfo;

/** @name Managing the Paging of the Table View */

/**
 Shows a Paging cell of the specified type
 
 @param type Type of paging cell to display
 @see FGPagingTableViewCell
 @see FGPagingCellType
 */
- (void)showPagingCellWithType:(FGPagingCellType)type;


/**
 Removes the paging cell from the table-view if it is currently visible
 */
- (void)removePagingCell;

/** @name Managing the Status Cell in the Table View */

/**
 Shows a Status cell of the specified type
 
 @param type Type of cell to display
 @see FGStatusTableViewCell
 @see FGStatusCellType
 */
- (void)showStatusCellWithType:(FGStatusCellType)type;


/**
 Removes the Status cell from the table-view if it is currently visible
 */
- (void)removeStatusCell;

@end
