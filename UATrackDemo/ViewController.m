//
//  ViewController.m
//  UATrackDemo
//
//  Created by ccguo on 16/8/27.
//  Copyright © 2016年 guochaoyang. All rights reserved.
//

#import "ViewController.h"
#import "UATrack.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recorderData:(id)sender
{
    [UATrack recorderEvent:@"eventId" attributes:@{@"key" : @"123"} eventType:@"1"];
}
@end
