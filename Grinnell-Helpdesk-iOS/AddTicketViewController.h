//
//  AddTicketViewController.h
//  Grinnell-Helpdesk-iOS
//
//  Created by Lea Marolt on 3/3/13.
//
//

#import <UIKit/UIKit.h>

@interface AddTicketViewController : UIViewController


- (void)registerForKeyboardNotifications;
- (IBAction)machineTypeDidBeginEditing;
- (IBAction)issueTitleDidBeginEditing;
- (IBAction)campusMachineDidBeginEditing;
- (IBAction)doneChoosing:(id)sender;
- (IBAction)clearButtonTapped:(id)sender;
- (IBAction)submitButtonTapped:(id)sender;


@property (nonatomic, strong) NSMutableArray *campusMachineArray;
@property (nonatomic, strong) NSMutableArray *machineTypeArray;

@property (nonatomic, weak) IBOutlet UITextView *activeView;

@property (nonatomic, strong) IBOutlet UIPickerView *machineTypePicker;
@property (nonatomic, strong) IBOutlet UIPickerView *campusMachinePicker;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UIToolbar *doneBar;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UITextField *machineType;
@property (nonatomic, weak) IBOutlet UITextField *campusMachine;
@property (nonatomic, weak) IBOutlet UITextField *issueTitle;
@property (nonatomic, weak) IBOutlet UITextView *issueDescription;
@property (nonatomic, weak) IBOutlet UIButton *submit;
@property (nonatomic, weak) IBOutlet UIButton *clear;

@end
