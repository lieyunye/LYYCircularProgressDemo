//
//  LYYCircularProgressView.m
//  LYYCircularProgressDemo
//
//  Created by lieyunye on 2016/12/23.
//  Copyright © 2016年 lieyunye. All rights reserved.
//

#import "LYYCircularProgressView.h"
#import "LYYProgressLayer.h"

@interface LYYCircularProgressView ()
@property (nonatomic, strong) LYYProgressLayer *progressLayer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGPoint progressCenter;
@property (nonatomic, assign) CGFloat progressRadius;
@property (nonatomic, assign) CGFloat progressLineWidth;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, strong) UIColor *intervalColor;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, assign) CGFloat initTotalTime;
@property (nonatomic, assign) CGFloat interval;
@property (nonatomic, assign) CGFloat totalInterval;


@property (nonatomic, strong) NSMutableArray *layerArray;
@property (nonatomic, strong) NSMutableArray *intervalLayerArray;

@end

@implementation LYYCircularProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _layerArray = [[NSMutableArray alloc] initWithCapacity:0];
        _intervalLayerArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        _progressCenter = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
        _progressRadius = frame.size.width / 2.0;
        _progressLineWidth = 10;
        _progressColor = [UIColor greenColor];
        _intervalColor = [UIColor blackColor];
        _initTotalTime = 10.0;
        _interval = 0.1;
        self.progressLayer = [self createLayerWithCenter:self.progressCenter radius:self.progressRadius lineWidth:self.progressLineWidth color:self.progressColor strokeStart:0 strokeEnd:0];
        [self.layer addSublayer:self.progressLayer];
        [self.layerArray addObject:self.progressLayer];
        
        [self startTimer];
    }
    return self;
}

- (LYYProgressLayer *)createLayerWithCenter:(CGPoint)center radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color strokeStart:(CGFloat)strokeStart strokeEnd:(CGFloat)strokeEnd
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:- M_PI_2 endAngle:(M_PI + M_PI_2) clockwise:YES];
    LYYProgressLayer *layer = [LYYProgressLayer layer];
    layer.contentsScale = [[UIScreen mainScreen] scale];
    layer.frame = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2);
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = color.CGColor;
    layer.lineWidth = lineWidth;
    layer.lineCap = kCALineJoinBevel;
    layer.lineJoin = kCALineJoinBevel;
    layer.path = path.CGPath;
    layer.strokeStart = strokeStart;
    layer.strokeEnd = strokeEnd;
    return layer;
}

- (void)refreshProgress
{
    self.time++;
    LYYProgressLayer *layer = self.layerArray.lastObject;
    CGFloat percet = 1 / self.initTotalTime;
    CGFloat strokeEnd = layer.strokeEnd + percet;
    layer.strokeEnd = strokeEnd;
    if (round(strokeEnd * 100) >= 100) {
        [self pauseProgress];
    }
}

- (void)addNewProgress
{
    if (self.time >= self.initTotalTime) {
        return;
    }
    [self pauseProgress];
    LYYProgressLayer *lastLayer = self.layerArray.lastObject;
    CGFloat strokeStart = lastLayer.strokeEnd;
    LYYProgressLayer *layer = [self createLayerWithCenter:self.progressCenter radius:self.progressRadius lineWidth:self.progressLineWidth color:self.progressColor strokeStart:strokeStart strokeEnd:strokeStart];
    layer.startTime = self.time;
    [self.layer addSublayer:layer];
    [self.layerArray addObject:layer];
    
    CGFloat strokeEnd = strokeStart + self.interval / self.initTotalTime;
    LYYProgressLayer *intervalLayer = [self createLayerWithCenter:self.progressCenter radius:self.progressRadius lineWidth:self.progressLineWidth color:self.intervalColor strokeStart:strokeStart strokeEnd:strokeEnd];
    [self.layer addSublayer:intervalLayer];
    [self.intervalLayerArray addObject:intervalLayer];
    
    [self startTimer];
}

- (void)removeProgress
{
    if (self.layerArray.count == 0) {
        return;
    }
    LYYProgressLayer *layer = self.layerArray.lastObject;
    if (layer.deleteStatus == DeleteStatusWillBeDelete) {
        [layer removeFromSuperlayer];
        [self.layerArray removeLastObject];
        
        LYYProgressLayer *intervalLayer = self.intervalLayerArray.lastObject;
        [intervalLayer removeFromSuperlayer];
        [self.intervalLayerArray removeLastObject];

        self.time -= layer.interval;
        NSLog(@"self.time ++++ %f   layer.interval +++++ %f",self.time,layer.interval);
    }else {
        layer.deleteStatus = DeleteStatusWillBeDelete;
        layer.strokeColor = [UIColor redColor].CGColor;
    }
}

- (void)pauseProgress
{
    [self stopTimer];
    LYYProgressLayer *layer = self.layerArray.lastObject;
    layer.endTime = self.time;

}

- (void)startTimer
{
    [self stopTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshProgress) userInfo:nil repeats:YES];

}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
@end
