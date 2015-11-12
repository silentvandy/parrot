//
//  FBOrderModel.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBOrderModel.h"

@implementation FBOrderModel

@dynamic orderStatusInfo;

- (NSString *)orderStatusInfo
{
    NSString *info = nil;
    switch (self.orderStatus) {
        case kOrderStateOutDate:
            info = @"订单已过期";
            break;
        case kOrderStateCancel:
            info = @"订单已取消";
            break;
        case kOrderStateWaitForPay:
            info = @"等待付款";
            break;
        case kOrderStateWaitForVerify:
            info = @"等待审核";
            break;
        case kOrderStatePayFail:
            info = @"支付失败";
            break;
        case kOrderStateWaitForSend:
            info = @"正在配货";
            break;
        case kOrderStateRefund:
            info = @"退款中";
            break;
        case kOrderStateRefundSuccess:
            info = @"退款成功";
            break;
        case kOrderStateHaveSend:
            info = @"已发货";
            break;
        case kOrderStateSendComplete:
            info = @"购买完成";
            break;
        default:
            break;
    }
    return info;
}


@end
