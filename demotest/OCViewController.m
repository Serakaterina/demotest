//
//  OCViewController.m
//  demotest
//
//  Created by Phoenix on 2020/11/26.
//

#import "OCViewController.h"

#import "demotest-Swift.h"

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.lightGrayColor;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    DKLDatePickerManager *manager = [DKLDatePickerManager new];
//    manager.isOpenDateJudgement = YES;
//    manager.pickerMode = DKLDatePickerModeYearMonthDayHourMinuteSecond;
//    manager.unitMode = DKLDateUnitModeFixed;
////    manager.hourUnit = @":";
////    manager.minuteUnit = @"";
////    manager.secondUnit = @"";
////    manager.baseViewCornerRadius = 10;
////    manager.rightButtonTextColor = UIColor.redColor;
//    manager.startDate = [[NSDate alloc] init];
//    DKLDatePickerView *view = [DKLDatePickerView initWithManager:manager completed:^(NSDate * _Nonnull date) {
//        NSLog(@"date:%@", date);
//    } failureBlock:^{
//        NSLog(@"时间选择错误啦");
//    }];
//    [view show];
    
}

@end
