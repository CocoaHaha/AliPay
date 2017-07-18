//
//  AppDelegate.h
//  ZhifubaoPayDemo
//
//  Created by 1 on 15/12/15.
//  Copyright (c) 2015年 Lee. All rights reserved.
//
/*
 https://openhome.alipay.com/platform/home.htm
 
 
 请求参数说明
 https://doc.open.alipay.com/doc2/detail?treeId=59&articleId=103663&docType=1
 

 支付宝配置过程
 1.登录支付宝开放平台，如图1
 2.首次登陆需要填写开发者联系方法，如图2
 3.创建应用，如图3，有个数限制10个
 4.提交应用等待审核，如图4。
 5.使用终端生成公钥（rsa_public_key.pem）和私钥（rsa_private_key.pem），如图5
 6.上传公钥，获取私钥，如图6。
 7.打开私钥，获取私钥，如图7。
 8.在商家服务找到"合作者身份(PID)"，如图8
 9.添加seller_id，用户号
 工程配置
 1.将AlipaySDK拖入工程中。
 2.添加SystemConfiguration.framework
 3.在Header Search Paths 添加AlipaySDK路径。
 $(PROJECT_DIR)/ChatPay/AlipaySDK
 4.在入口类添加回调方法
 5.IOS9以上需要添加URL Scheme 白名单
 
 <key>LSApplicationQueriesSchemes</key>
 <array>
 <!-- 支付宝  URL Scheme 白名单-->
 <string>alipay</string>
 <string>alipayshare</string>
 </array>
 
 如何生成公钥和私钥
 1.打开 OpenSSL
 1、生成私钥pem,  执行命令   genrsa -out rsa_private_key.pem 1024
 2、生成公钥,执行命令   rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem
 3、将RSA私钥转换成PKCS8格式,命令执行 pkcs8 -topk8 -inform PEM -in rsa_private_key.pem -outform PEM -nocrypt
 
iOS9 URL Scheme 适配_引入白名单概念
 
 */
#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
