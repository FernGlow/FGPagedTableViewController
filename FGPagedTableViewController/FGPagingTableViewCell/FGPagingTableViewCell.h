//
//  FGPagingTableViewCell.h
//  FGPagedTableViewController
//
//  Created by Andrew Michaelson on 10/27/10.
//  Copyright 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
	FGPagingCellTypeNone		= 300,
	FGPagingCellTypeContinue	= 301,
	FGPagingCellTypeRetrieving	= 302
} FGPagingCellType;

@interface FGPagingTableViewCell : UITableViewCell

/** @name Manging Text as Cell Content */

/**
 Returns the label used for the main textual content of the paging table view cell. (read-only)
 */
@property (nonatomic, strong, readonly) IBOutlet UILabel *statusLabel;


/**
 Returns the secondary label of the paging table view cell. (read-only)
 */
@property (nonatomic, strong, readonly) IBOutlet UILabel *detailsLabel;


/**
 Returns the activity indicator view the table view cell. (read-only)
 */
@property (nonatomic, strong, readonly) IBOutlet UIActivityIndicatorView *spinnerView;


/**
 The type of paging table view cell.
 */
@property (nonatomic, assign) FGPagingCellType cellType;

@end
