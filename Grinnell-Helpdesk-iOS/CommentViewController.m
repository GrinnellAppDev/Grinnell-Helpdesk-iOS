//
//  CommentViewController.m
//  Grinnell-Helpdesk-iOS
//
//  Created by Lea Marolt on 4/7/13.
//
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController
@synthesize commentTextView, doneBar, submitButton, cancelButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    commentTextView.text = @"\n\nSent from my iPhone";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitComment:(id)sender{
    if (![commentTextView.text isEqualToString:@"\n\nSent from my iPhone"])
        //Save the comment
        ;
    
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)cancelComment:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

@end
