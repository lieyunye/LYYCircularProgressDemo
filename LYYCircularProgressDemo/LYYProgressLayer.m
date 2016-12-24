//
//  LYYProgressLayer.m
//  LYYCircularProgressDemo
//
//  Created by lieyunye on 2016/12/23.
//  Copyright © 2016年 lieyunye. All rights reserved.
//

#import "LYYProgressLayer.h"

@implementation LYYProgressLayer
- (NSTimeInterval)interval
{
    if (self.endTime == 0) {
        return 0;
    }
    return self.endTime - self.startTime;
}
@end
