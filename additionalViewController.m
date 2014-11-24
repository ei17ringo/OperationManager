//
//  additionalViewController.m
//  OperationManeger
//
//  Created by Ryohei Terakata on 2014/08/14.
//  Copyright (c) 2014年 Ryohei Terakata. All rights reserved.
//

#import "additionalViewController.h"
#import <UIKit/UIKit.h>

@interface MyButton : UIButton
{
    NSUInteger section;
    NSUInteger row;
}

@property (nonatomic, readwrite) NSUInteger section;
@property (nonatomic, readwrite) NSUInteger row;

@end


@interface additionalViewController ()
{
    NSArray *_favoriteList;
    
}

@end

@implementation additionalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favouriteList =[userDefaults mutableArrayValueForKey:@"favoriteList"];

    if (favouriteList.count > 0) {
        _favoriteList = favouriteList.copy;
    }
    
    
self.additionalList.delegate = self;
self.additionalList.dataSource = self;
    
    

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    return _favoriteList.count;
    
}
    

    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    
        static NSString *CellIndentifier=@"Cell";
        
        //セルの再利用
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
        if(cell==nil)
        {
            //表示スタイルを決定
            cell=[[UITableViewCell alloc]
                  initWithStyle:
                  UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
        }
        
        
        NSLog(@"row:: %@", _favoriteList[indexPath.row]);
        NSDictionary *dic = _favoriteList[indexPath.row];
        NSLog(@"dict:: %@", dic[@"Name"]);
        cell.textLabel.text=[NSString stringWithFormat:@"%@", dic[@"Name"]];
        
        
        NSDictionary *how = dic[@"how to"];
        NSLog(@"content:: %@", how[@"content"]);
    
        
        return cell;
    }

    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
