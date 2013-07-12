//
//  CustomTableView.h
//  JSONAlpha
//
//  Created by kaushal on 12/07/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol CustomTableViewDelegate <NSObject>

-(void)customTableViewRowClicked:(NSString*)url;

@end

@interface CustomTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property id<CustomTableViewDelegate> delegate_;
@property NSArray * array;
- (id)initWithFrame:(CGRect)frame array:(NSArray *)array;

@end
