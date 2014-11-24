//
//  DetailViewController.m
//  SampleTableView003
//
//  Created by Ryohei Terakata on 2014/07/17.
//  Copyright (c) 2014年 Ryohei Terakata. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
    
    NSLog(@"dvc=%d",self.selectnum);
    NSLog(@"dvc=%@",self.content);
    
    self.contentTextVew.text=self.content;
    
    //textViewを角丸にする
    [[self.contentTextVew layer] setCornerRadius:10.0];
    [self.contentTextVew setClipsToBounds:YES];
    
    //textViewに黒色の枠を付ける
    [[self.contentTextVew layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.contentTextVew layer] setBorderWidth:1.0];

    //self.contentTextVew.layer = [UIColor blackColor];
    [[self.contentTextVew layer] setBackgroundColor:[[UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1] CGColor]];
    self.contentTextVew.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
