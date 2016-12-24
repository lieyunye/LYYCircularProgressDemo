//
//  LYYProgressLayer.h
//  LYYCircularProgressDemo
//
//  Created by lieyunye on 2016/12/23.
//  Copyright © 2016年 lieyunye. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef enum : NSUInteger {
    DeleteStatusNone,
    DeleteStatusWillBeDelete,
} DeleteStatus;

@interface LYYProgressLayer : CAShapeLayer
@property (nonatomic, assign) DeleteStatus deleteStatus;
@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval endTime;
@property (nonatomic, assign) NSTimeInterval interval;

@end
