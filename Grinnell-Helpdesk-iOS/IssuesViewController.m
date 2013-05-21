//
//  IssuesViewController.m
//  Grinnell-Helpdesk-iOS
//
//  Created by Colin Tremblay on 2/11/13.
//  Copyright (c) 2013 __GrinnellAppDev__. All rights reserved.
//

#import "IssuesViewController.h"
#import "Ticket.h"
#import "AddTicketViewController.h"
#import "TicketViewController.h"

@implementation IssuesViewController
@synthesize theTableView, noIssueImage, cellIdentifier;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Ticket *tic = [[Ticket alloc] init];
    tic.number = @"000000";
    tic.title = @"This is my ticket title";
    tic.modified = [[NSDate alloc] init];
    tic.created = [[NSDate alloc] initWithTimeIntervalSinceNow:-60*60*24];
    tic.status =  @"Opened";
    tic.comment = @"This is the user comment";
    NSString *a = @"the first comment is super super long because the last TC was incredibly over zealous and now we have a really long comment that wraps onto multiple lines";
    NSString *b = @"2nd comment";
    NSString *c = @"3rd comment";
    NSString *d = @"fourth comment";
    NSString *e = @"fifth comment";
    tic.commentsArray = [[NSMutableArray alloc] initWithObjects:a, b, c, d, e, tic.comment, nil];
    
    ticketArray = [[NSMutableArray alloc] initWithObjects:tic, nil];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // Add button to add issues
    UIBarButtonItem *plus = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                          target:self
                                                                          action:@selector(newIssue:)];
    [self.navigationItem setRightBarButtonItem:plus animated:YES];
    
    
    // Add call button if the device cam make calls
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]){
        UIBarButtonItem *phoneButton =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"phone"]
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(call:)];
        [self.navigationItem setLeftBarButtonItem:phoneButton animated:YES];
    }
    
	cellIdentifier = @"Cell";
    self.title = @"My Issues";

    if (ticketArray == nil) {
        UIImage *noIssues = [UIImage imageNamed: @"NoIssues6.png"];
        [noIssueImage setImage:noIssues];
        theTableView.hidden = YES;
        noIssueImage.hidden  = NO;
    }
    else {
        self.theTableView.backgroundColor = [UIColor clearColor];
        self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"TiledBG.png"]];
        theTableView.hidden = NO;
        noIssueImage.hidden  = YES;
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section {
    return ticketArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
	}
   
    // Get the article for this cell
    Ticket *currentTicket = [[Ticket alloc] init];
    currentTicket = [ticketArray objectAtIndex:indexPath.row];
    cell.textLabel.text = currentTicket.title;
    cell.detailTextLabel.text = currentTicket.number;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketViewController *ticketPage = [[TicketViewController alloc] initWithNibName:@"TicketViewController" bundle:nil];
    ticketPage.ticket = [[Ticket alloc] init];
    ticketPage.ticket = [ticketArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:ticketPage animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)call:(id)sender {
    NSString *url = [[NSString alloc] initWithFormat:@"tel:641-269-4400"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)newIssue:(id)sender {
    AddTicketViewController *addTicket = [[AddTicketViewController alloc] initWithNibName:@"AddTicketViewController" bundle:nil];
    [self.navigationController pushViewController:addTicket animated:YES];
}


@end
