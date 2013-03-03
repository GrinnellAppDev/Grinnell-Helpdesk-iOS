//
//  ViewController.m
//  Grinnell-Helpdesk-iOS
//
//  Created by Colin Tremblay on 2/11/13.
//  Copyright (c) 2013 __GrinnellAppDev__. All rights reserved.
//

#import "ViewController.h"
#import "Ticket.h"
#import "AddTicketViewController.h"
#import "TicketViewController.h"

@implementation ViewController
@synthesize theTableView, noIssueImage, cellIdentifier;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        theTableView.hidden = YES;
        noIssueImage.hidden  = NO;
    }
    else {
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
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
	}
   
    // Get the article for this cell
    Ticket *currentTicket = [[Ticket alloc] init];
    currentTicket = [ticketArray objectAtIndex:indexPath.row];
    
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
