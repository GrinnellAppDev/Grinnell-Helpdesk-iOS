//
//  TicketViewController.m
//  Grinnell-Helpdesk-iOS
//
//  Created by Lea Marolt on 3/3/13.
//
//

#import "TicketViewController.h"
#import "CommentViewController.h"

@interface TicketViewController ()

@end

@implementation TicketViewController
@synthesize ticket, issueTitle, created, modified, status, scroll;
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
    
    self.title = [NSString stringWithFormat:@"Issue #%@", ticket.number];
    issueTitle.text = ticket.title;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter  setDateFormat:@"MMMM d, YYYY"];
    NSString *formattedDate = [dateFormatter stringFromDate:ticket.created];
    created.text = formattedDate;
    formattedDate = [dateFormatter stringFromDate:ticket.modified];
    modified.text = formattedDate;
    status.text = ticket.status;
    
    UIBarButtonItem *commentButton =[[UIBarButtonItem alloc] initWithTitle:@"Comment"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(createComment:)];
    [self.navigationItem setRightBarButtonItem:commentButton animated:YES];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"TiledBG.png"]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Start at 118 to handle the labels at the top
    // This value will be the y value of each comment box
    int sumOfHeights = 150;
    for (int i = 0; i < ticket.commentsArray.count; i++){
    
        NSString *comment = [ticket.commentsArray objectAtIndex:i];
        
    // Get the needed height for the text view (so it doesn't scroll)
    CGSize textViewSize = [comment sizeWithFont:[UIFont fontWithName:@"Palatino" size:12]
                                      constrainedToSize:CGSizeMake(self.view.frame.size.width - 16,
                                                                   FLT_MAX)
                                          lineBreakMode:UILineBreakModeWordWrap];
    
    // Set up the text view so it doesn't scroll and add it to the scroll view
    UITextView *commentBox = [[UITextView alloc] initWithFrame:
                   CGRectMake(0, sumOfHeights, self.view.frame.size.width, textViewSize.height + 16)];
    commentBox.text = comment;
    commentBox.font = [UIFont fontWithName:@"Palatino" size:12];
    commentBox.editable = NO;
    [scroll addSubview:commentBox];
        sumOfHeights += textViewSize.height + 16;
    
    }
    
    
    // Set the scroll view large enough to contain everything
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, sumOfHeights);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createComment:(id)sender{
    CommentViewController *modalVC = [[CommentViewController alloc] init];
    [self presentViewController:modalVC animated:YES completion:nil];
    
}
@end
