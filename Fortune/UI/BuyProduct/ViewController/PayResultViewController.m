//
//  PayResultViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/7/3.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PayResultViewController.h"

@interface PayResultViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@end

@implementation PayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sureButton.layer.borderColor = RGB(0, 128, 0).CGColor;
    self.sureButton.layer.borderWidth = 1;
    [self createNavWithTitle: @"支付完成" leftImage: @"" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sureButtonClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
