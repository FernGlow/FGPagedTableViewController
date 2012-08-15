//
//  FGPagingTableViewCell.m
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
