//
//  LiveMsg.h
//  LiveMsgTable
//
//  Created by AlexiChen on 2017/6/23.
//  Copyright © 2017年 AlexiChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveMsg : NSObject

@property (nonatomic, assign) NSInteger msgHeight;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger msgLevel;
@property (nonatomic, assign) NSInteger msgType;

@end
