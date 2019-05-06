//
//  NameCalculateViewController.m
//  Fortune
//
//  Created by Sj03 on 2018/5/15.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "NameCalculateViewController.h"
#import "NameCalculateViewModel.h"
#import "ResultNameViewController.h"
#import "ResultNameViewModel.h"

@interface NameCalculateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong)NameCalculateViewModel *viewModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopConstraint;

@end

@implementation NameCalculateViewController

- (void)initData {
    self.viewModel = [[NameCalculateViewModel alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"姓名测算" leftImage:@"Whiteback" rightText:@""];
    self.theSimpleNavigationBar.backgroundColor = defaultColor;
    [self.theSimpleNavigationBar.titleButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    [[self.nameTextField.rac_textSignal filter:^BOOL(NSString * str) {
        return str.length > 0;
    }] subscribeNext:^(id x) {
        self.viewModel.name = x;
    }];
    
    self.viewModel.block_reloadDate = ^{
        ResultNameViewController *RVC = [[ResultNameViewController alloc] init];
        RVC.viewModel.model = self.viewModel.model;
        RVC.viewModel.isgetDate = NO;
        [self.navigationController pushViewController:RVC animated:YES];
    };
    self.viewTopConstraint.constant = iPhoneX ? 88 : 64;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)applyAction:(id)sender {
    [self.viewModel.subject_getDate sendNext:@YES];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if ([string containsString:@"-"] || [string containsString:@"+"]) {
        // 禁止粘贴"-"和"+"
        return NO;
    }
    
    NSMutableString *mutableString = [NSMutableString stringWithString:textField.text];
    if ([string isEqualToString:@""]) {
        //删除
        [mutableString deleteCharactersInRange:range];
    }else{
        [mutableString replaceCharactersInRange:range withString:string];
    }
    if ([self filterCharactor:string withRegex:@"[^\u4E00-\u9FA5]"]) {
        return NO;
    }
    
    if (mutableString.length > 5 ) {
        return NO;
    } else {
        return YES;
    }
}

//根据正则，过滤特殊字符
- (BOOL)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    return [predicate evaluateWithObject:string];
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
