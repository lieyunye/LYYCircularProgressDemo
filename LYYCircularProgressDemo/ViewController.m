//
//  ViewController.m
//  LYYCircularProgressDemo
//
//  Created by lieyunye on 2016/12/23.
//  Copyright © 2016年 lieyunye. All rights reserved.
//

#import "ViewController.h"
#import "LYYCircularProgressView.h"

@interface ViewController ()
@property (nonatomic, strong) LYYCircularProgressView *circularProgressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.circularProgressView = [[LYYCircularProgressView alloc] initWithFrame:CGRectMake(100, 100, 82, 82)];
    [self.view addSubview:self.circularProgressView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAction:(id)sender {
    [self.circularProgressView addNewProgress];
}

- (IBAction)pauseAction:(id)sender {
    [self.circularProgressView pauseProgress];
}

- (IBAction)removeProgress:(id)sender {
    [self.circularProgressView removeProgress];

}


@end
