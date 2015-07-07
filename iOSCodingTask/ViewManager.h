//
//  ViewManager.h
//  iOSCodingTask
//
//  Created by Ahmed Elashker on 7/6/15.
//  Copyright (c) 2015 Ahmed Elashker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "RequestManager.h"

@interface ViewManager : NSObject

+ (ViewManager*)sharedInstance;

@property (nonatomic, strong) UINavigationController *navigationController;

@property UIView *viewDim;
@property UIView *viewLoading;
@property UILabel *lblLoading;
@property UIActivityIndicatorView *indicator;

- (void)showVL:(UIView*)sentView;

- (void)updateProgress:(int)count;

- (void)hideVL;

- (void)adjustToThisCenter:(CGPoint)centerPoint;

@end
