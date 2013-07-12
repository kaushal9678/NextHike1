//
//  CustomCell.m
//  JSONAlpha
//
//  Created by kaushal on 12/07/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize webView,label_Name,image_Avatar;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    /*if (self) {
     // Initialization code
     
     self = [[[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil] objectAtIndex:0];
     
     }*/
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        // Running on iPhone or iPod touch
        self=[[[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil] objectAtIndex:0];
        
    } else {
        // Running on iPad
        self=[[[NSBundle mainBundle] loadNibNamed:@"CustomCell_iPad" owner:self options:nil] objectAtIndex:0];
    }
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
