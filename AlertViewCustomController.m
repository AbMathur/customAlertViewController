//
//  AlertViewCustomController.m
//  SmartChk_diagnostics
//
//  Created by Abhilash Mathur on 30/05/16.
//  Copyright © 2016 Xcaliber. All rights reserved.
//

#import "AlertViewCustomController.h"
@implementation AlertViewCustomController
@synthesize alertCont,alert;

-(id)init{
    
    self = [super init];
    
    return self;
}
/**  @brief shared instance for alertView
   @return return the shared instane .
 */
+ (id)sharedInstance
{
    static AlertViewCustomController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AlertViewCustomController alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}


/**! @brief   Method to call AlertView,  Handling the condition for iOS 8 above and below.
    @param title :title of alertview 
    @param btnArray :required button array on alertview .
    @param cancel : to show cancel button on alertview .
    @param message :  nsstring messages on alert view .
    @param viewController controller on which alertwant to display as parant viewController.
 */
-(void)showAlertWithTitle:(NSString *)title withButton:(NSArray *)btnArray withCancelButton:(BOOL)cancel withMessage:(NSString *)message onView:(UIViewController *)viewController{
    
   //Take Application shared instanace to get rootview Controller on which alert will display .
       if ([self supportAlertViewController]) {
        
        UIAlertAction *cancelButton;
        
         alertCont =   [UIAlertController
                                      alertControllerWithTitle:NSLocalizedString(title, nil)
                                      message:NSLocalizedString(message, nil)
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        for (int i = 0; i < [btnArray count]; i++) {
            UIAlertAction *action;
            action = [UIAlertAction actionWithTitle:NSLocalizedString([btnArray objectAtIndex:i], nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                
                NSString *btnTitle = action.title;
                [self.delegate alertViewButtonDelegateCallBackHandler:btnTitle];
                NSLog(@"delegate value:%@",self.delegate);
                
            }];
            
            [alertCont addAction:action];
        }
        
        
        if (cancel) {
            cancelButton = [UIAlertAction actionWithTitle:NSLocalizedString(CANCELBTN, nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                
                NSString *btnTitle = action.title;
                [self.delegate alertViewButtonDelegateCallBackHandler:btnTitle];
            }];
            [alertCont addAction:cancelButton];
        }
        
          [viewController presentViewController:alertCont animated:YES completion:nil];
        
        
    }
    else{
        
        // This else is called if device is not supporting UIAlertController i.e OS of device is below iOS 8.
        NSLog(@"UIAlertController not supported!");
        
    
        alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(title, nil) message:NSLocalizedString(message, nil) delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        
        for (NSString * obj in btnArray)
        {
            [alert addButtonWithTitle:NSLocalizedString(obj, nil)];
        }
        
        if (cancel) {
            [alert addButtonWithTitle:NSLocalizedString(CANCELBTN, nil)];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
             [alert show];
        });
    }
    
}

-(void)dismissAlert{
    
    if ([self supportAlertViewController]) {
        
    [self.alertCont dismissViewControllerAnimated:YES completion:nil];
        
    }
    else{
        
        [self.alert dismissWithClickedButtonIndex:-1 animated:NO];
        
    }
}

/*! delegate method for UIAlertViewDelegate system API's.*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"ButtonIndex called:%ld",(long)buttonIndex);
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    [self.delegate alertViewButtonDelegateCallBackHandler:title];
    
}
/*! @brief Method to check support for UIAlertController(Supports starts from iOS 8). @return Yes if support UIAlertController
 */
- (BOOL) supportAlertViewController {
    Class AlertViewClass = NSClassFromString(@"UIAlertController");
    return !AlertViewClass ? NO : YES;
}






@end
