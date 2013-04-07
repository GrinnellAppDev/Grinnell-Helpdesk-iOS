//
//  CommentViewController.h
//  Grinnell-Helpdesk-iOS
//
//  Created by Lea Marolt on 4/7/13.
//
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController

- (IBAction)submitComment:(id)sender;
- (IBAction)cancelComment:(id)sender;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *submitButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, weak) IBOutlet UIToolbar *doneBar;
@property (nonatomic, weak) IBOutlet UITextView *commentTextView;

@end
