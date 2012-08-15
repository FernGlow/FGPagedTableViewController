//
//  FGStatusTableViewCell.m
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
