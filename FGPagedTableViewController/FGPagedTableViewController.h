//
//  FGPagedTableViewController.h
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

#import <UIKit/UIKit.h>
#import "FGStatusTableViewCell.h"
#import "FGPagingTableViewCell.h"
#import "FGPageInfo.h"

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
Returns the paging cell if visible, otherwise returns nil. (read-only)
*/
@property (nonatomic, strong, readonly) FGPagingTableViewCell *pagingCell;


/**
 Object that encapsulates the paging data.
 
 This object should be updated every time data is added or removed from the data source.

 @see FGPageInfo
 */
@property (nonatomic, strong) FGPageInfo *pageInfo;

/** @name Managing the Paging of the Table View */

/**
 Returns the status cell if visible, otherwise returns nil. (read-only)
 */
@property (nonatomic, strong, readonly) FGStatusTableViewCell *statusCell;


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
