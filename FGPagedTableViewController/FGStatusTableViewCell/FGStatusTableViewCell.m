//
//  FGStatusTableViewCell.m
//  FGPagedTableViewController
//
//  Created by Andrew Michaelson on 10/27/10.
//  Copyright 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//

#import "FGStatusTableViewCell.h"


@implementation FGStatusTableViewCell

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

- (void)setCellType:(FGStatusCellType)cellType
{	
	_cellType = cellType;

	switch (self.cellType) {
		case FGStatusCellTypeSearching:
		{
			self.selectionStyle = UITableViewCellSelectionStyleNone;
			self.tag = FGStatusCellTypeSearching;
			self.spinnerView.hidesWhenStopped = YES;
			[self.spinnerView startAnimating];
			self.statusLabel.textColor = [UIColor darkGrayColor];
			self.detailsLabel.textColor = [UIColor darkGrayColor];
			self.statusLabel.text = @"Performing Search on Server...";
			self.detailsLabel.text = @"Speed varies based on connectivity";
			break;
		}
		case FGStatusCellTypeNoResults:
		{
			self.selectionStyle = UITableViewCellSelectionStyleNone;
			self.tag = FGStatusCellTypeNoResults;
			self.spinnerView.hidesWhenStopped = YES;
			[self.spinnerView stopAnimating];
			self.statusLabel.textColor = [UIColor darkGrayColor];
			self.detailsLabel.textColor = [UIColor darkGrayColor];
			self.statusLabel.text = @"No Results Found on Server";
			self.detailsLabel.text = @"Please modify your search and try again";
			break;
		}
		case FGStatusCellTypeNetworkError:
		{
			self.selectionStyle = UITableViewCellSelectionStyleNone;
			self.tag = FGStatusCellTypeNetworkError;
			self.spinnerView.hidesWhenStopped = YES;
			[self.spinnerView stopAnimating];
			self.statusLabel.textColor = [UIColor darkGrayColor];
			self.detailsLabel.textColor = [UIColor darkGrayColor];
			self.statusLabel.text = @"A Network Error Has Occured";
			self.detailsLabel.text = @"Please check your settings and try again";
			break;
		}
		case FGStatusCellTypeAuthenticating:
		{
			self.selectionStyle = UITableViewCellSelectionStyleNone;
			self.tag = FGStatusCellTypeAuthenticating;
			self.spinnerView.hidesWhenStopped = YES;
			[self.spinnerView startAnimating];
			self.statusLabel.textColor = [UIColor darkGrayColor];
			self.detailsLabel.textColor = [UIColor darkGrayColor];
			self.statusLabel.text = @"Authenticating...";
			self.detailsLabel.text = @"One moment please";
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
