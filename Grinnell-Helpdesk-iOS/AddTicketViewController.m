//
//  AddTicketViewController.m
//  Grinnell-Helpdesk-iOS
//
//  Created by Lea Marolt on 3/3/13.
//
//

#import "AddTicketViewController.h"
#import "Ticket.h"

@interface AddTicketViewController ()

@end

@implementation AddTicketViewController
@synthesize machineType, campusMachine, clear, submit, issueDescription, issueTitle, machineTypeArray, machineTypePicker, activeView, scrollView, doneBar, doneButton, campusMachinePicker, campusMachineArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    machineTypePicker.hidden = YES;
    campusMachinePicker.hidden = YES;
    campusMachine.hidden = YES;
    doneBar.hidden = YES;
    self.title = @"Submit an Issue";
    [self registerForKeyboardNotifications];
    self.machineType.inputView = self.machineTypePicker;
    self.campusMachine.inputView = self.campusMachinePicker;

    self.machineTypeArray = [[NSMutableArray alloc] initWithObjects:@"Personal Machine", @"Campus Computer", @"Campus Printer", @"Other", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) alertStatus:(NSString *)msg :(NSString *)title{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)submitButtonTapped:(id)sender{
    if (![issueTitle.text isEqualToString:@""] && ![issueDescription.text isEqualToString:@""]){
        Ticket *newTic = [[Ticket alloc] init];
        newTic.title = issueTitle.text;
        newTic.comment = issueDescription.text;
        newTic.number = @"0000001";
        newTic.status = @"New";
        newTic.created = [[NSDate alloc] init];
        newTic.modified = newTic.created;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
        [self alertStatus:@"Please fill all required fields." :@"Error!"];
}

- (IBAction)clearButtonTapped:(id)sender{
    self.machineType.text = @"Personal Machine";
    self.campusMachine.text = @"";
    self.issueTitle.text = @"";
    self.issueDescription.text = @"";
}

#pragma mark UIPicker methods
- (IBAction)issueTitleDidBeginEditing{
    self.machineTypePicker.hidden = YES;
    self.doneBar.hidden = NO;
}

- (IBAction)machineTypeDidBeginEditing{
    self.doneBar.hidden = NO;
  // self.machineTypePicker = [[UIPickerView alloc] init];
    self.machineTypePicker.hidden = NO;
}
- (IBAction)campusMachineDidBeginEditing{
    self.doneBar.hidden = NO;
   // self.campusMachinePicker = [[UIPickerView alloc] init];
    self.campusMachinePicker.hidden = NO;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([pickerView isEqual:machineTypePicker])
        return [self.machineTypeArray objectAtIndex:row];
    else
        return [self.campusMachineArray objectAtIndex:row];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([pickerView isEqual:machineTypePicker])
        return self.machineTypeArray.count;
    else
        return self.campusMachineArray.count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([pickerView isEqual:machineTypePicker]){
        self.machineType.text = [self.machineTypeArray objectAtIndex:row];
        if ([self.machineType.text rangeOfString:@"Campus"].location != NSNotFound)
            campusMachine.hidden = NO;
        else
            campusMachine.hidden = YES;
    }
    else
       self.campusMachine.text = [self.campusMachineArray objectAtIndex:row];
    
}

- (IBAction)doneChoosing:(id)sender {
    [self.machineType resignFirstResponder];
    [self.campusMachine resignFirstResponder];
    [self.issueDescription resignFirstResponder];
    [self.issueTitle resignFirstResponder];
    self.doneBar.hidden = YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.doneBar.hidden = NO;
    self.activeView = textView;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    self.doneBar.hidden = YES;
    self.activeView = nil;
    self.machineTypePicker.hidden = YES;
    self.campusMachinePicker.hidden = YES;
}
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification{
 
    if(self.activeView){
        NSDictionary* info = [aNotification userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        double offset = kbSize.height/2;
        offset = self.issueDescription.frame.origin.y - 32;
        CGPoint scrollPoint = CGPointMake(0.0, offset);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    if (theTextField == self.issueTitle){
        activeView = self.issueDescription;
        [theTextField resignFirstResponder];
        [self.issueDescription becomeFirstResponder];
    }
    return YES;
}
// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
    CGPoint scrollPoint = CGPointMake(0.0, 0.0);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}





@end
