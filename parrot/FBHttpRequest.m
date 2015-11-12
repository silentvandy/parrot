//
//  FBHttpRequest.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBHttpRequest.h"

#import "JSONKit.h"
#import "Reachability.h"
#import "FBConfig.h"


@implementation FBHttpRequest

@synthesize delegate = _delegate, requestUrl = _requestUrl;

// 获取数据
- (void)getInfoWithParams:(NSDictionary *)params andUrl:(NSString *)urlString {
    self.requestUrl = [NSString stringWithFormat:@"%@%@", kBaseUrl, urlString];
    NSString *serUrl = [[self class] serializeURL:self.requestUrl params:params httpMethod:@"GET"];
    NSLog(@"Request url: %@", serUrl);
    NSURL *url = [NSURL URLWithString:serUrl];
    if (_httpReqeust) {
        [_httpReqeust clearDelegatesAndCancel];
        _httpReqeust = nil;
    }
    _httpReqeust = [[ASIHTTPRequest alloc] initWithURL:url];
    _httpReqeust.shouldAttemptPersistentConnection = NO;
    
    _httpReqeust.delegate = self;
    
    [_httpReqeust startAsynchronous];
}

// 提交数据
- (void)postInfoWithParams:(NSDictionary *)params andUrl:(NSString *)urlString {
    self.requestUrl = [NSString stringWithFormat:@"%@%@", kBaseUrl, urlString];
    NSString *serUrl = self.requestUrl;
    NSURL *url = [NSURL URLWithString:serUrl];
    if (_formDataReqeust) {
        [_formDataReqeust clearDelegatesAndCancel];
        _formDataReqeust = nil;
    }
    _formDataReqeust = [[ASIFormDataRequest alloc] initWithURL:url];
    NSArray *paramKeys = [params allKeys];
    for (NSString *key in paramKeys) {
        NSString *value = [params objectForKey:key];
        [_formDataReqeust setPostValue:value forKey:key];
    }
    [_formDataReqeust setDelegate:self];
    [_formDataReqeust startAsynchronous];
}

// 上传文件
- (void)postFileWithParams:(NSDictionary *)params andUrl:(NSString *)urlString {
    self.requestUrl = [NSString stringWithFormat:@"%@%@", kBaseUrl, urlString];
    NSString *serUrl = self.requestUrl;
    NSURL *url = [NSURL URLWithString:serUrl];
    if (_formDataReqeust) {
        [_formDataReqeust clearDelegatesAndCancel];
        _formDataReqeust = nil;
    }
    _formDataReqeust = [[ASIFormDataRequest alloc] initWithURL:url];
    NSArray *paramKeys = [params allKeys];
    for (NSString *key in paramKeys) {
        // todo: 对上传文件验证处理
        if (![key isEqualToString:@"pic"]) {
            NSString *value = [params objectForKey:key];
            [_formDataReqeust setPostValue:value forKey:key];
        } else {
            UIImage *img = [params objectForKey:key];
            [_formDataReqeust setData:UIImageJPEGRepresentation(img, .6) withFileName:@"head.jpg" andContentType:@"image/jpeg" forKey:key];
        }
    }
    _formDataReqeust.shouldAttemptPersistentConnection = NO;
    [_formDataReqeust setDelegate:self];
    [_formDataReqeust startAsynchronous];
}

// 从返回的URL中读取参数
+ (NSString *)getParamValueFromUrl:(NSString *)url paramName:(NSString *)paramName {
    if (![paramName hasSuffix:@"="]) {
        paramName = [NSString stringWithFormat:@"%@=", paramName];
    }
    
    NSString *str = nil;
    NSRange start = [url rangeOfString:paramName];
    if (start.location != NSNotFound) {
        // confirm that the parameter is not a partial name match
        unichar c = '?';
        if (start.location != 0) {
            c = [url characterAtIndex:start.location - 1];
        }
        if (c == '?' || c == '&' || c == '#') {
            NSRange end = [[url substringFromIndex:start.location + start.length] rangeOfString:@"&"];
            NSUInteger offset = start.location + start.length;
            str = end.location == NSNotFound ? [url substringFromIndex:offset] : [url substringWithRange:NSMakeRange(offset, end.location)];
            str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    
    return str;
}

// 判断网络是否通畅
- (BOOL)isNetReachability {
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    if (conn.currentReachabilityStatus == NotReachable) {
        return NO;
    }
    return YES;
}

+ (NSString *)serializeURL:(NSString *)baseUrl params:(NSDictionary *)params httpMethod:(NSString *)httpMethod {
    
    NSURL *parsedURL = [NSURL URLWithString:baseUrl];
    
    NSString *queryPrefix = parsedURL.query ? @"&" : @"?";
    
    NSMutableArray *pairs = [NSMutableArray array];
    for (NSString *key  in [params keyEnumerator]) {
        if (([[params objectForKey:key] isKindOfClass:[UIImage class]]) || ([[params objectForKey:key] isKindOfClass:[NSData class]])) {
            continue;
        }
        
        NSString *escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, /* allocator */
                                                                                                        (CFStringRef)[params objectForKey:key],
                                                                                                        NULL, /* charactersToLeaveUnescaped */
                                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                        kCFStringEncodingUTF8));
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
    }
    NSString *query = [pairs componentsJoinedByString:@"&"];
    
    return [NSString stringWithFormat:@"%@%@%@", baseUrl, queryPrefix, query];
}

#pragma mark - Json

// 处理返回数据
- (void)handleResponseData:(NSString *)response {
    NSError *error = nil;
    id data = nil;
    NSLog(@"%@", response);
    id result = [self parseJsonData:response error:&error];
    if (!result) {
        NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"数据解析出错，请稍后重试!", NSLocalizedDescriptionKey, nil];
        error = [self errorWithCode:kNetError errorInfo:errorInfo];
        [self failedWithError:error];
    }
    
    if (error) {
        [self failedWithError:error];
    } else {
        NSError *error = nil;
        if ([result isKindOfClass:[NSDictionary class]]) {
            int status = [[result objectForKey:@"status"] intValue];
            if (!(status == 0) && !(status == 1)) {
                NSString *msg = [result objectForKey:@"message"];
                NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                           msg, NSLocalizedDescriptionKey, nil];
                
                error = [self errorWithCode:kServerError errorInfo:errorInfo];
                [self failedWithError:error];
            } else {
                data = [result objectForKey:@"data"];
                [self finishWithResult:data];
            }
        }
    }
}


// 对数据进行Json解析
- (id)parseJsonData:(NSString *)data error:(NSError **)error {
    id ret = [data objectFromJSONString];
    // 解析错误
    if ([data length] > 0 && !ret && (error != nil)) {
        NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"数据解析出错，请稍后重试!", NSLocalizedDescriptionKey, nil];
        *error = [self errorWithCode:kParseError errorInfo:errorInfo];
    }
    
    return ret;
}

- (id)errorWithCode:(NSInteger)code errorInfo:(NSDictionary *)errorInfo {
    return [NSError errorWithDomain:kDomain code:code userInfo:errorInfo];
}

#pragma mark - ASI Delegate

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *response = [request responseString];
    [self handleResponseData:response];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [self failedWithError:error];
}

#pragma mark - 处理结果

- (void)failedWithError:(NSError *)error {
    [_delegate fbRequest:self didFailLoading:error];
}

- (void)finishWithResult:(id)ret {
    [_delegate fbRequest:self didFinishLoading:ret];
}

#pragma mark - 销毁处理

- (void)cleanDelegatesAndCancel {
    self.delegate = nil;
    
    [_httpReqeust clearDelegatesAndCancel];
    _httpReqeust = nil;
    
    [_formDataReqeust clearDelegatesAndCancel];
    _formDataReqeust = nil;
}

- (void)dealloc {
    _httpReqeust = nil;
    _formDataReqeust = nil;
    
    self.requestUrl = nil;
}

@end
