//
//  Call_Service.m
//  JSONAlpha
//
//  Created by kaushal on 12/07/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "Call_Service.h"
#import "SVProgressHUD.h"

@implementation Call_Service

NSDictionary * receipt;
static Call_Service * _sharedInstance = nil;


+(Call_Service *)shareInstance// Singlton Class
{
    @synchronized(self) {
        if (_sharedInstance == nil) {
			_sharedInstance =  [[Call_Service alloc] init];
        }
    }
    return _sharedInstance;
}
@synthesize responseData;


-(void)call_service :(NSString *)url
{  // this method is used to call webservice url
    
    if (![self is_ConnectedToNetwork]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Internet service not available!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
        [alert show];
        return;
    }
    
    NSLog(@"URL : %@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]cachePolicy:NSURLCacheStorageAllowed timeoutInterval:30.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (theConnection) {
        self.responseData = [NSMutableData data];
    }
    
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
}


#pragma mark connection delegates

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"ERROR: %@", [NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Could not connect to the server!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
    [alert show];
    
    [SVProgressHUD dismiss];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //	[connection release];
    //NSString *responceString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSError * error;
    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    
    
    
    [self.delegate_ call_service_Response:dict];
    [SVProgressHUD dismiss];
    
}




#pragma mark To Detect Wifi  > Kaushal(Kaushlendra)

- (BOOL)is_ConnectedToNetwork
{
    // this method is used to check user is connected to internet or not
    
	// Create zero addy
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags)
	{
		printf("Error. Could not recover network reachability flags\n");
		return NO;
	}
	
	BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
	BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    
    BOOL isConnected = (isReachable && !needsConnection) ? YES : NO;
    
    if (!isConnected) {
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"No internet connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ] ;
        [alert show];
    }
    
	return isConnected;
}


@end
