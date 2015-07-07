//
//  ViewManager.m
//  iOSCodingTask
//
//  Created by Ahmed Elashker on 7/6/15.
//  Copyright (c) 2015 Ahmed Elashker. All rights reserved.
//

#import "ViewManager.h"

@implementation ViewManager

@synthesize viewDim, viewLoading, lblLoading, indicator;

+ (ViewManager*)sharedInstance
{
    static ViewManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    if (self = [super init])
    {
        [self initNavigationController];
        
        [self initViewLoading];
    }
    return self;
}

- (void)initNavigationController
{
    _navigationController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
}

- (void)initViewLoading
{
    viewDim = [[UIView alloc] init];
    
    viewLoading = [[UIView alloc] init];
    viewLoading.alpha = 0.7;
    viewLoading.backgroundColor = [UIColor grayColor];
    viewLoading.layer.cornerRadius = 5;
    
    lblLoading = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 50)];
    lblLoading.textColor = [UIColor whiteColor];
    lblLoading.backgroundColor = [UIColor clearColor];
    
    indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
}

- (void)showVL:(UIView*)sentView
{
    viewDim.frame = sentView.frame;
    
    [sentView addSubview:viewDim];
    
    [viewDim addSubview:viewLoading];
    
    lblLoading.text = @"Loading";
    
    [self labelAdjustsView];
    [self adjustToThisCenter:viewDim.center];
    
    [viewLoading addSubview:lblLoading];
    
    [indicator startAnimating];
    [viewLoading addSubview:indicator];
}

- (void)updateProgress:(int)count
{
    NSString *progress = [NSString stringWithFormat:@"%d of %d", count, [RequestManager sharedInstance].imgViews.count];
    lblLoading.text = progress;
    
    [self labelAdjustsView];
    [self adjustToThisCenter:viewDim.center];
    
    [viewLoading addSubview:lblLoading];
    
    [indicator startAnimating];
    [viewLoading addSubview:indicator];
}

- (void)adjustToThisCenter:(CGPoint)centerPoint
{
    viewLoading.center = centerPoint;
    indicator.center = CGPointMake(lblLoading.center.x, lblLoading.center.y + 40);
}

- (void)labelAdjustsView
{
    [lblLoading sizeToFit];
    
    CGSize sze;
    sze.height = 100;
    sze.width = lblLoading.frame.size.width + 20;
    
    viewLoading.frame = CGRectMake(0, 0, sze.width, sze.height);
    viewLoading.center = viewDim.center;
}

- (void)hideVL
{
    [lblLoading removeFromSuperview];
    
    [indicator stopAnimating];
    
    [indicator removeFromSuperview];
    
    [viewLoading removeFromSuperview];
    
    [viewDim removeFromSuperview];
}
@end
