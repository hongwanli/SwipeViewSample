//
//  ViewController.m
//  SwipeViewSample
//
//  Created by neolix on 14-8-1.
//  Copyright (c) 2014年 Neolix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView * upView;
@property (nonatomic, strong) UIView * downView;
@property (nonatomic, assign) CGFloat startX;
@property (nonatomic, assign) CGFloat endX;
@property (nonatomic, assign) BOOL isShow;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _upView = [[UIView alloc] initWithFrame:self.view.bounds];
    _upView.backgroundColor = [UIColor whiteColor];
    _upView.layer.cornerRadius = 9.0f;
    _upView.layer.borderWidth = 2.0f;
    _upView.layer.borderColor = (__bridge CGColorRef)([UIColor lightGrayColor]);
    _downView = [[UIView alloc] initWithFrame:self.view.bounds];
    _downView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_downView];
    [self.view addSubview:_upView];
    UIPanGestureRecognizer * panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panRecognizer.delegate = self;
    [self.view addGestureRecognizer:panRecognizer];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.startX = [recognizer locationInView:self.view].x;
        NSLog(@"startX===%f",_startX);
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        CGPoint currentPoint = [recognizer  locationInView:self.view];
//        self.endX = [recognizer locationInView:_upView].x;
        if (currentPoint.x - self.startX < -20 && !self.isShow) {
            [UIView animateWithDuration:0.3 animations:^{
                _upView.frame = CGRectMake(-200, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            } completion:^(BOOL finished) {
                self.isShow = YES;
            }];
        }else if (currentPoint.x - self.startX > 20 && self.isShow){
            [UIView animateWithDuration:0.3 animations:^{
                _upView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            } completion:^(BOOL finished) {
                self.isShow = NO;
            }];
        }
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.view];
        //当x轴移动的距离大于y轴时 相应该手势
        return fabs(translation.x) > fabs(translation.y);
    }
    return YES;
}

@end
