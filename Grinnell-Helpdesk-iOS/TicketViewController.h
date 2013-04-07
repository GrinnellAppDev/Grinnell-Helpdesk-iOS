//
//  TicketViewController.h
//  Grinnell-Helpdesk-iOS
//
//  Created by Lea Marolt on 3/3/13.
//
//

#import <UIKit/UIKit.h>
#import "Ticket.h"

@interface TicketViewController : UIViewController

- (void)createComment:(id)sender;
@property (nonatomic, strong) Ticket *ticket;
@property (nonatomic, weak) IBOutlet UILabel *issueTitle;
@property (nonatomic, weak) IBOutlet UILabel *created;
@property (nonatomic, weak) IBOutlet UILabel *modified;
@property (nonatomic, weak) IBOutlet UILabel *status;
@property (nonatomic, weak) IBOutlet UIScrollView *scroll;
@end
