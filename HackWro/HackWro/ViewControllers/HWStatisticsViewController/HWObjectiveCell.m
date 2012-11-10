//
//  HWObjectiveCell.m
//  HackWro
//
//  Created by Jakub Kaluzka on 10.11.2012.
//  Copyright (c) 2012 ploomworks. All rights reserved.
//

#import "HWObjectiveCell.h"

@implementation HWObjectiveCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
