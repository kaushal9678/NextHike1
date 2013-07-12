//
//  ViewController.m
//  JSONAlpha
//
//  Created by kaushal on 12/07/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "ViewController.h"

#import "Call_Service.h"
#import "CustomTableView.h"
#import "WebViewController.h"

@interface ViewController ()<Call_ServiceDelegate,CustomTableViewDelegate>

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self callService:@"https://alpha-api.app.net/stream/0/users/1/posts"];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)callService:(NSString *)url{// Hitting URL
    [Call_Service shareInstance].delegate_=self;
    [[Call_Service shareInstance]call_service:url];
}

-(void)call_service_Response:(NSDictionary *)dict_response{ // Got web-service response
    NSArray * array=[dict_response objectForKey:@"data"];
    CustomTableView * table=[[CustomTableView alloc]initWithFrame:self.view.frame array:array];
    table.delegate_=self;
    [self.view addSubview:table];
    
}

-(void)customTableViewRowClicked:(NSString *)url{
    
    [self.navigationController setNavigationBarHidden:NO];
    
    WebViewController * webView=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    
    webView.url=url;
    [self.navigationController pushViewController:webView animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
