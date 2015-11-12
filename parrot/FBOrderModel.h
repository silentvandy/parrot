//
//  FBOrderModel.h
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    kOrderStateOutDate = -1,//订单过期
    kOrderStateCancel = 0,//取消订单
    kOrderStateWaitForPay = 1,//待付款
    kOrderStateWaitForVerify = 5,//等待审核
    kOrderStatePayFail = 6,//支付失败
    kOrderStateWaitForSend = 10,//待发货
    kOrderStateRefund = 12,//申请退款
    kOrderStateRefundSuccess = 13,//退款成功
    kOrderStateHaveSend = 15,//已发货
    kOrderStateSendComplete = 20,//完成
} OrderState;

@interface FBOrderModel : NSObject

@property (nonatomic, copy) NSString *orderID;
@property (nonatomic, assign) float orderTotalMoney;
@property (nonatomic, copy) NSString *orderUserName;
@property (nonatomic, assign) OrderState orderStatus;
@property (nonatomic, readonly) NSString* orderStatusInfo;
@property (nonatomic, retain) NSArray *orderItems;

@end
