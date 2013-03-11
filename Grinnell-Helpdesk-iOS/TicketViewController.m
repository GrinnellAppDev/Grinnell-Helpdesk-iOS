//
//  TicketViewController.m
//  Grinnell-Helpdesk-iOS
//
//  Created by Lea Marolt on 3/3/13.
//
//

#import "TicketViewController.h"

@interface TicketViewController ()

@end

@implementation TicketViewController
@synthesize ticket, issueTitle, created, modified, status;
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
    created.text = [ticket.created descriptionWithCalendarFormat:@"%m-%d-%YYYY"
                                                        timezone:nil
                                                          locale:nil];
//                    descriptionWithLocale:@"%m-%d-%YYYY"];
    modified.text = [ticket.modified descriptionWithLocale:@"%m-%d-%YYYY"];
    status.text = ticket.status;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
