//
//  Mybutton.m
//  OperationManeger
//
//  Created by Ryohei Terakata on 2014/08/15.
//  Copyright (c) 2014年 Ryohei Terakata. All rights reserved.
//

#import "Mybutton.h"

@implementation Mybutton

@synthesize section;
@synthesize row;
@synthesize HowTo;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)buttonDidTouchDown:(id)sender {
    
    Mybutton *theButton = (Mybutton *)sender;
    NSLog(@"Button[%d,%d] was pressed.", theButton.section, theButton.row);
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favouriteList =[userDefaults mutableArrayValueForKey:@"favoriteList"];
    
    
    // お気に入りとして登録してあるデータをチェックする。
    // もし、既に登録してあれば、お気に入りから削除して処理を終了
    //（終了というのは、returnの部分です。returnを書くとそれ以降の処理をせずに終了します。）
    for(NSDictionary *favoriteHowto in favouriteList){
        if ([favoriteHowto isEqual:self.HowTo]) {
            // 既にお気に入り登録されている場合は、お気に入り解除
            [favouriteList removeObject:favoriteHowto];
            [theButton setTitle:@"" forState:UIControlStateNormal];
            return;
        }
    }
    
    // section Aを通りこして、ここまで処理が進んだということは、
    // お気に入りに登録されていない状態なので、新規に登録する。
    [favouriteList addObject:self.HowTo];
    [theButton setTitle:@"★" forState:UIControlStateNormal];
    
    //Ichinohe 対応（下記2行コメントアウト、return;追記）
//    [userDefaults setObject:favouriteList forKey:@"favolirtelist"];
//    [userDefaults synchronize];
    
    return;

}

@end
