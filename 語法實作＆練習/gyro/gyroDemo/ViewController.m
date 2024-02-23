//
//  ViewController.m
//  gyrowdemo
//
//  Created by 李韋辰 on 2023/6/15.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) BOOL isBowing;
@property (nonatomic, assign) NSInteger bowCount;
@property (nonatomic, assign) double previousX;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *x;
@property (weak, nonatomic) IBOutlet UILabel *y;
@property (weak, nonatomic) IBOutlet UILabel *z;
@property (nonatomic, assign) NSInteger stage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 陀螺儀初始化
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 0.1; // 更新频率
    
    self.isBowing = NO;
    self.bowCount = 0;
    self.previousX = 0;
    self.stage = 0;
    
    // 監聽陀螺儀改變
    if (self.motionManager.isDeviceMotionAvailable) {
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            
            double y = motion.rotationRate.y;
            double x = motion.rotationRate.x;
            double z = motion.rotationRate.z;
            self->_x.text = [NSString stringWithFormat:@"%ld", (long)x];
            self->_y.text = [NSString stringWithFormat:@"%ld", (long)y];
            self->_z.text = [NSString stringWithFormat:@"%ld", (long)z];
            
            // 依閥值決定是否增加次數
            if (x > 2.0 && self->_stage == 1) {
                self->_stage = 0;
                if (!self.isBowing) {
                    self.isBowing = YES;
                    [self incrementBowCount];
                }
            } else {
                self.isBowing = NO;
            }
            
            if (x < -2) {
                self->_stage = 1;
            }
            
            self.previousX = x;
        }];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 停止监听陀螺仪数据
    [self.motionManager stopDeviceMotionUpdates];
}
- (IBAction)onPress:(id)sender {
    
    self.label.text = @"0";
    self.bowCount = 0;
    
}

- (void)incrementBowCount {
    // 每次拜拜动作增加次数
    
    double delayInSeconds = 0.3;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        self.bowCount++;
        self.label.text = [NSString stringWithFormat:@"%ld", (long)self->_bowCount];
    });
    // 在这里可以执行相关操作，例如更新 UI 或显示拜拜次数
    NSLog(@"Bow Count: %ld", (long)self.bowCount);
}

@end
