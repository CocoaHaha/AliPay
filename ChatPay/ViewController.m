//
//  ViewController.m
//  ZhifubaoPayDemo
//
//  Created by 1 on 15/12/15.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "Order.h"

#define PartnerID @"2088021052830430"
#define SellerID  @"2042733061@qq.com"
#define RSAPrivateKey @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMaKhwll4nvzwDsz67beCzSZCUbEM5VQMq4NHE6lLxzPHVFC7iPCYw2uJm2iZLhgxsKDGebVTk9H15N4m7aUDTpVtcvXmg5c5OQlvwbwAOGZdvpet57NRDnWK53uuIVh31VK31Q9McG3C9ZITvGq8h5ug4e1IjnTUojSmf/Nxcw1AgMBAAECgYEAs3rVWiSVmrIejCaCptyRyqmx3hxN+WP3fKpzdZEURvngqe5Uc1Ut0FcnfCK65IbwBzUW/DrGQRtUAYedVG8AiKw1dKWmeI3gMIoXAWG6G22n8Evzpcpdw9lLehCncMbS2Z8jP1ey5X9pqY6oNqlBa4CmAGBAxT2od8+gG3YJ5Z0CQQDwPNqGYeWhAuZmBBCoi9D2niNywno75MEQi9zhJqv2W1CnbDdlQHBpeYXdiyt26EQwdeoFMGsWhd9KBcsxCScXAkEA05FReRAr3GDLbeIWRfStdeyFpu3hWqGw1lLNsQT+l74/HF/grXc+OE+ze/EeK0H+FK+Jxltu6YpvmvGWTla2kwJABXgdMXoBFE1QmXn2NyAXvcWT4QT0a3ClxI6qlKWgvJcPmwAnsrJo3L3bglOsxaQ8CS5mCYA0r+qUTsca/R7MOQJBAKCIY4m4+4784189bikmv3f7QG6pkZVzmvsFWY44e/YoJTsihRkaoduYnlgtXPb13BVWHPSl7ELJCGZJagOHSIECQQCFixVZJrFfKFWOgXmI9vhYjHv+zp77ma7Mq9OmaThyAQg1Lclz4oyyvnxKg/eIzBuhCuZov0MnPqWAIaz0vmMu"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //公钥
//    @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDGiocJZeJ788A7M+u23gs0mQlGxDOVUDKuDRxOpS8czx1RQu4jwmMNriZtomS4YMbCgxnm1U5PR9eTeJu2lA06VbXL15oOXOTkJb8G8ADhmXb6XreezUQ51iud7riFYd9VSt9UPTHBtwvWSE7xqvIeboOHtSI501KI0pn/zcXMNQIDAQAB";
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44.0f)];
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.text = @"火车票";
    _nameTextField.placeholder = @"商品名称";
    [self.view addSubview:_nameTextField];
    
    _priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44.0f)];
    _priceTextField.borderStyle = UITextBorderStyleRoundedRect;
    _priceTextField.text = @"0.01";
    _priceTextField.placeholder = @"商品价格";
    _priceTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.view addSubview:_priceTextField];
    
    
    //私钥
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"支付" forState:UIControlStateNormal];
    button.frame =CGRectMake(100, 100, 80, 80);
    
    [self.view addSubview:button];
    

    
}


-(void)btnClick:(UIButton *)button{
    //使用私钥进行签名
    //生成点单
    Order *order = [[Order alloc]init];
    //合作者身份(PID)
    order.partner =PartnerID  ;
    //商家支付宝账号
    order.seller = SellerID;
    //订单ID
    order.tradeNO = [[[NSDate date] description] substringToIndex:11];//@"20160104055712";
    order.productName = _nameTextField.text;
    order.productDescription = @"商品描述";
    //商品价格
    order.amount = _priceTextField.text;
    //回调URL
    order.notifyURL = @"http://www.zhiyou100.com";
    //Bundle ID
    order.service = @"mobile.securitypay.pay";
    //支付类型：1（商品购买）
    order.paymentType = @"1";
    //编码格式
    order.inputCharset = @"utf-8";
    //订单超时时间
    order.itBPay = @"30m";
    
    NSString * appSchem = @"ZhifubaoPayDemo";
    NSString *orderSpec = [order description];
    
    //使用私钥进行签名
    id<DataSigner>signer = CreateRSADataSigner(RSAPrivateKey);
    //签名我的订单描述
    NSString *sinedString = [signer signString:orderSpec];
    
    NSString *orderString = nil;
    
    if (sinedString != nil) {
        
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec,sinedString,@"RSA"];
        
        [[AlipaySDK defaultService]payOrder:orderString fromScheme:appSchem callback:^(NSDictionary *resultDic) {
            NSLog(@"result= %@",resultDic);
        }];
    }
}

@end
