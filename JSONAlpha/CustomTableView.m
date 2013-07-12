//
//  CustomTableView.m
//  JSONAlpha
//
//  Created by kaushal on 12/07/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "CustomTableView.h"
#import "CustomCell.h"
#import "UIImageView+AFNetworking.h"
@implementation CustomTableView

@synthesize array;

float cellHeight;
- (id)initWithFrame:(CGRect)frame array:(NSArray *)array_
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        array=array_;
        
        self.delegate=self;
        self.dataSource=self;
        
        self.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            // Running on iPhone or iPod touch
            cellHeight=98;
            
        } else {
            // Running on iPad
            cellHeight=170;
        }
    }
    return self;
}

#pragma tableview datasource methods

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [array count];
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier=@"cell";
    
    CustomCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    UIButton * button=[[UIButton alloc]initWithFrame:cell.webView.frame];
    button.backgroundColor=[UIColor clearColor];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:button];
    button.tag=indexPath.row;
    
    cell.label_Name.text=[[[array objectAtIndex:indexPath.row] objectForKey:@"user"]objectForKey:@"username"];
    
    [cell.webView loadHTMLString:[[[[array objectAtIndex:indexPath.row]objectForKey:@"user"]objectForKey:@"description"]objectForKey:@"html"] baseURL:nil];
    [cell.image_Avatar setImageWithURL:[NSURL URLWithString:[[[[array objectAtIndex:indexPath.row]objectForKey:@"user"]objectForKey:@"avatar_image"]objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@""]];
    
    
    
    
    return cell;
    
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self fireDelagete:indexPath.row];
}

-(void)click:(UIButton*)button{
    [self fireDelagete:button.tag];
}

-(void)fireDelagete:(int)index{
    NSString * url=[[[[array objectAtIndex:index]objectForKey:@"user"]objectForKey:@"description"]objectForKey:@"html"];
    [self.delegate_ customTableViewRowClicked:url];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end
