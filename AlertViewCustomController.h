//
//  AlertViewCustomController.h
//  SmartChk_diagnostics
//
//  Created by Abhilash Mathur on 30/05/16.
//  Copyright © 2016 Xcaliber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define STARTBTN NSLocalizedString(@"START", nil)
#define YESBTN NSLocalizedString(@"Yes", nil)
#define NOBTN  NSLocalizedString(@"No", nil)
#define OKBTN NSLocalizedString(@"OK", nil)
#define CANCELBTN NSLocalizedString(@"Cancel", nil)


@protocol AlertViewCustomDelegate <NSObject>

-(void)alertViewButtonDelegateCallBackHandler:(NSString *)buttonTitle;


@end

@interface AlertViewCustomController : NSObject<UIAlertViewDelegate>
@property (weak,nonatomic)id<AlertViewCustomDelegate> delegate;
@property (nonatomic) int tag;
@property (nonatomic, strong) UIAlertController *alertCont;
@property (nonatomic, strong) UIAlertView *alert;

+ (id)sharedInstance;
-(void)showAlertWithTitle:(NSString *)title withButton:(NSArray*)btnArray withCancelButton:(BOOL)cancel withMessage:(NSString *)message onView:(UIViewController*)viewController;
-(void)dismissAlert;
@end
