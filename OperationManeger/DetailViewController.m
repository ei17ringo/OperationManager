//
//  DetailViewController.m
//  SampleTableView003
//
//  Created by Ryohei Terakata on 2014/07/17.
//  Copyright (c) 2014年 Ryohei Terakata. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    ALAssetsLibrary *_library;  //ALAssetsLibraryのインスタンス

}

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
    
    //メモ画像の反映
    _library = [[ALAssetsLibrary alloc] init];
    
    [self setImageMemo];
    
    //メモテキストの反映
    
}

-(void)setImageMemo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *memoList =[userDefaults mutableArrayValueForKey:@"memoList"];
    
    //既に保存されているメモデータがある場合は取り出す
    NSDictionary *memoDic = [[NSDictionary alloc] init];
    
    BOOL searchFlag = NO;
    for (NSDictionary *memoDicTmp in memoList) {
        if ([memoDicTmp[@"No"] intValue] == self.selectnum) {
            memoDic = memoDicTmp;
            searchFlag = YES;
            break;
        }
    }

    NSURL *assetURL = [NSURL URLWithString:memoDic[@"memoUrl"]];
                       
    [_library assetForURL:assetURL
             resultBlock:^(ALAsset *asset) {
                 
                 //画像があればYES、無ければNOを返す
                 if(asset){
                     NSLog(@"データがあります");
                     
                     UIImage *img = [UIImage imageWithCGImage:[asset thumbnail]];
                     self.memoThumb.image = img; //イメージをセット
                 }else{
                     NSLog(@"データがありません");
                 }
                 
             } failureBlock: nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


- (IBAction)tapMemo:(id)sender {
    
    //アクションシートの初期化
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    
    //タイトルの設定
    actionSheet.title = @"どちらのメモを残しますか？";
    
    actionSheet.delegate = self;
    
    [actionSheet addButtonWithTitle:@"画像"];
    [actionSheet addButtonWithTitle:@"テキスト"];
    
    [actionSheet addButtonWithTitle:@"キャンセル"];

    [actionSheet setCancelButtonIndex:2];
    [actionSheet showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    switch (buttonIndex) {
        case 0:
            NSLog(@"画像");
            [self showUIImagePicker];

            break;
        case 1:
            NSLog(@"テキスト");
            
            break;
        case 2:
            NSLog(@"キャンセル");
            
            break;
        default:
            NSLog(@"何か押されました");
            //TODO:メッセージ表示「Enjoy,anyway!」
            
            break;
    }

}


- (void)showUIImagePicker
{
    // カメラが使用可能かどうか判定する
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    // UIImagePickerControllerのインスタンスを生成
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    // デリゲートを設定
    imagePickerController.delegate = self;
    
    // 画像の取得先をカメラに設定
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // 画像取得後に編集するかどうか（デフォルトはNO）
    imagePickerController.allowsEditing = YES;
    
    // 撮影画面をモーダルビューとして表示する
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

// 画像が選択された時に呼ばれるデリゲートメソッド
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    // 渡されてきた画像をフォトアルバムに保存
    [_library writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL* assetUrl, NSError* error){
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSMutableArray *memoList =[userDefaults mutableArrayValueForKey:@"memoList"];
        
            //既に保存されているメモデータがある場合は取り出す
            NSDictionary *memoDic = [[NSDictionary alloc] init];
        
            BOOL searchFlag = NO;
            for (NSDictionary *memoDicTmp in memoList) {
                if ([memoDicTmp[@"No"] intValue] == self.selectnum) {
                    memoDic = memoDicTmp;
                    searchFlag = YES;
                    break;
                }
            }
        
            if (!searchFlag) {
               memoDic = @{@"No":[NSString stringWithFormat:@"%d",self.selectnum],@"memoUrl":[assetUrl absoluteString],@"memoText":@""};
            }else{
                [memoDic setValue:[assetUrl absoluteString] forKey:@"memoUrl"];
            }
            
        
            [memoList addObject:memoDic];
            
            [userDefaults setObject:memoList forKey:@"memoList"];

        
    }];
    
    self.memoThumb.image = image;
    
    // モーダルビューを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];

    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(targetImage:didFinishSavingWithError:contextInfo:), NULL);
}

// 画像の選択がキャンセルされた時に呼ばれるデリゲートメソッド
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // モーダルビューを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//画像の完了時に呼ばれるメソッド
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
//    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *memoList =[userDefaults mutableArrayValueForKey:@"memoList"];
//    
//    //既に保存されているメモデータがある場合は取り出す
//    NSDictionary *memoDic = [[NSDictionary alloc] init];
//    
//    BOOL searchFlag = NO;
//    for (NSDictionary *memoDicTmp in memoList) {
//        if ([memoDic[@"No"] intValue] == self.selectnum) {
//            memoDic = memoDicTmp;
//            searchFlag = YES;
//            break;
//        }
//    }
//    
//    if (!searchFlag) {
//       memoDic = @{@"memoUrl":[assetURL absoluteString],@"memoText":@""};
//    }else{
//        [memoDic setValue:[assetURL absoluteString] forKey:@"memoUrl"];
//    }
//    
//
//    [memoList addObject:memoDic];
//    
//    [userDefaults setObject:memoList forKey:@"memoList"];
//    
//    //撮影した画像のサムネイルを表示
//    ALAssetsLibrary *library;  //ALAssetsLibraryのインスタンス
//    [library assetForURL:assetURL
//             resultBlock:^(ALAsset *asset) {
//                 
//                 //画像があればYES、無ければNOを返す
//                 if(asset){
//                     NSLog(@"データがあります");
//                     
//                     UIImage *img = [UIImage imageWithCGImage:[asset thumbnail]];
//                     self.memoThumb.image = img; //イメージをセット
//                 }else{
//                     NSLog(@"データがありません");
//                 }
//                 
//             } failureBlock: nil];}
//
// 画像の保存完了時に呼ばれるメソッド
- (void)targetImage:(UIImage *)image
didFinishSavingWithError:(NSError *)error
        contextInfo:(void *)context
{
    if (error) {
        // 保存失敗時の処理
    } else {
        // 保存成功時の処理
    }
}
@end
