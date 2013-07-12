//
//  Call_Service.h
//  JSONAlpha
//
//  Created by kaushal on 12/07/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <Foundation/Foundation.h>
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
