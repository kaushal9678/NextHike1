//
//  Call_Service.h
//  Yodl_
//
//  Created by Kaushal on 11/07/13.
//  Copyright (c) 2013 abc. All rights reserved.
//


#import <UIKit/UIKit.h>
// Internet
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#include <SystemConfiguration/SCNetworkReachability.h>

@protocol Call_ServiceDelegate <NSObject>

-(void)call_service_Response:(NSDictionary *)dict_response;

@end


@interface Call_Service : NSString

+(Call_Service *)shareInstance;
@property id <Call_ServiceDelegate> delegate_;
@property NSMutableData * responseData;



-(void)call_service :(NSString *)url;
- (BOOL)is_ConnectedToNetwork;

@end
