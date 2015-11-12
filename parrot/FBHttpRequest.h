//
//  FBHttpRequest.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"

@class FBHttpRequest;

@protocol FBHttpRequestDelegate <NSObject>

@required
-(void)fbRequest:(FBHttpRequest *)fbRequest didFinishLoading:(id)result;
-(void)fbRequest:(id)fbRequest didFailLoading:(NSError *)error;

@end

@interface FBHttpRequest : NSObject <ASIHTTPRequestDelegate> {
    ASIHTTPRequest                 *_httpReqeust;
    ASIFormDataRequest             *_formDataReqeust;
    id<FBHttpRequestDelegate>      _delegate;
    NSString                       *_requestUrl;
}

@property (nonatomic, copy)   NSString *requestUrl;
@property (nonatomic, retain) id<FBHttpRequestDelegate> delegate;

-(void)cleanDelegatesAndCancel;
-(void)getInfoWithParams:(NSDictionary *)params andUrl:(NSString *)urlString;
-(void)postInfoWithParams:(NSDictionary *)params andUrl:(NSString *)urlString;
-(void)postFileWithParams:(NSDictionary *)params andUrl:(NSString *)urlString;

@end
