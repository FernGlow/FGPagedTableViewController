//
//  FGPagingTableViewCell.m
//  FGPagedTableViewController
//
//  Created by Andrew Michaelson on 10/27/10.
//  Copyright 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//

#import "FGPagingTableViewCell.h"


@implementation FGPagingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellType:(FGPagingCellType)cellType
{	
	_cellType = cellType;

	switch (self.cellType) {
		case FGPagingCellTypeContinue:
		{
			self.selectionStyle = UITableViewCellSelectionStyleNone;
			self.tag = FGPagingCellTypeContinue;
			self.spinnerView.hidesWhenStopped = YES;
			[self.spinnerView stopAnimating];
			self.statusLabel.textColor = [self blueLinkColor];
			self.detailsLabel.textColor = [UIColor darkGrayColor];
			self.statusLabel.text = @"Retrieve More Results";
			break;
		}
		case FGPagingCellTypeRetrieving:
		{
			self.tag = FGPagingCellTypeRetrieving;
			self.selectionStyle = UITableViewCellSelectionStyleNone;
			[self.spinnerView startAnimating];
			self.statusLabel.textColor = [UIColor darkGrayColor];
			self.statusLabel.text = @"Retrieving Results From Server...";
			break;
		}
		default:
			break;
	}
}

- (UIColor *)blueLinkColor {
	float r = 36.0;
	float g = 112.0;
	float b = 216.0;
	float a = 1.0;
	float d = 255.0;
	
	return [UIColor colorWithRed:r/d green:g/d blue:b/d alpha:a];
}

@end
