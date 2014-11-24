//
//  Mybutton.h
//  OperationManeger
//
//  Created by Ryohei Terakata on 2014/08/15.
//  Copyright (c) 2014年 Ryohei Terakata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mybutton : UIButton
{
    NSUInteger section;
    NSUInteger row;
}

@property (nonatomic, readwrite) NSUInteger section;
@property (nonatomic, readwrite) NSUInteger row;
@property (nonatomic,strong) NSDictionary *HowTo;



@end
