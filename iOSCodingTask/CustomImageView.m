//
//  CustomImageView.m
//  iOSCodingTask
//
//  Created by Ahmed Elashker on 7/6/15.
//  Copyright (c) 2015 Ahmed Elashker. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

@synthesize lblDescription,lblPrice,imgView;

- (id)initWithProduct:(Product*)product
{
    self = [super init];
    
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        imgView = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:product.imageURL]]]];
        
        lblPrice = [[UILabel alloc] init];
        [lblPrice setText: [NSString stringWithFormat:@"$%@", [product.price stringValue]]];
        lblPrice.backgroundColor = [UIColor whiteColor];
        [lblPrice sizeToFit];
        
        lblDescription = [[UILabel alloc] init];
        lblDescription.numberOfLines = 0;
        [lblDescription setText:product.productDescription];
        [lblDescription setLineBreakMode:NSLineBreakByCharWrapping];
        
        UIFont *font = [UIFont systemFontOfSize:14.0]; //Warning! It's an example, set the font, you need
        
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              font, NSFontAttributeName,
                                              nil];
        
        CGSize maximumLabelSize = CGSizeMake(imgView.frame.size.width,9999);
        
        CGRect expectedLabelRect = [[lblDescription text] boundingRectWithSize:maximumLabelSize
                                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                          attributes:attributesDictionary
                                                             context:nil];
        CGSize expectedLabelSize = expectedLabelRect.size;
        
        [lblDescription setFrame:CGRectMake(0
                                            , imgView.frame.size.height
                                            , expectedLabelSize.width
                                            , expectedLabelSize.height)];
        
        [self setFrame:CGRectMake(0
                                  , 0
                                  , product.imageWidth.floatValue
                                  , product.imageHeight.floatValue + lblDescription.frame.size.height)];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [self addSubview:imgView];
    
    [self addSubview:lblDescription];
    
    [lblPrice setFrame:CGRectMake(imgView.frame.size.width - lblPrice.frame.size.width - 10
                                  , 20
                                  , lblPrice.frame.size.width
                                  , lblPrice.frame.size.height)];
    [self addSubview:lblPrice];
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        // Run UI Updates
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductDrawn" object:self];
    });
}

@end
