//
//  ViewController.m
//  iOSCodingTask
//
//  Created by Ahmed Elashker on 7/6/15.
//  Copyright (c) 2015 Ahmed Elashker. All rights reserved.
//

#import "ViewController.h"
#import "RequestManager.h"
#import "ViewManager.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize scrollView;

int count = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadProducts) name:@"ProductsResolved" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productLoaded) name:@"ProductDrawn" object:nil];
    
    [self setTitle:@"Products"];
    
    [[ViewManager sharedInstance] showVL:self.view];
    [[RequestManager sharedInstance] requestData];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [[ViewManager sharedInstance] adjustToThisCenter:self.view.center];
}

- (void)loadProducts
{
    int columnY1 = 0;
    int columnY2 = 0;
    
    for (int x = 0; x < [RequestManager sharedInstance].imgViews.count; x++)
    {
        CustomImageView *currentImg = [RequestManager sharedInstance].imgViews[x];
        
        // Decide whether to draw on col 1 or col 2
        if (columnY1 <= columnY2)
        {
            // Draw at col 1
            currentImg.frame = CGRectMake(0, columnY1, currentImg.frame.size.width, currentImg.frame.size.height);
            
            columnY1 += currentImg.frame.size.height + 10;
        }
        else if (columnY1 > columnY2)
        {
            // Draw at col 2
            currentImg.frame = CGRectMake(self.view.frame.size.width/2, columnY2, currentImg.frame.size.width, currentImg.frame.size.height);
            
            columnY2 += currentImg.frame.size.height + 10;
        }
        
        [scrollView addSubview:currentImg];
    }
    
    // Get maximum reached point of Y to set scroll content size
    CGFloat maxY;
    
    if (columnY1>columnY2)
    {
        maxY = columnY1 + ((CustomImageView*)[RequestManager sharedInstance].imgViews[[RequestManager sharedInstance].imgViews.count-1]).frame.size.height;
    }
    else
        maxY = columnY2 + ((CustomImageView*)[RequestManager sharedInstance].imgViews[[RequestManager sharedInstance].imgViews.count-2]).frame.size.height;
    
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, columnY1>columnY2?columnY1:columnY2 + ((CustomImageView*)[RequestManager sharedInstance].imgViews.lastObject).frame.size.height)];
}

- (void)productLoaded
{
    count++;
    
    if (count > 10)
    {
        [[ViewManager sharedInstance] updateProgress:count];
    }
    else if (count == 10)
    {
        [[ViewManager sharedInstance] hideVL];
    }
}

@end
