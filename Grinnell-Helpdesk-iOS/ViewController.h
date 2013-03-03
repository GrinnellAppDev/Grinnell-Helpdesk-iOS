//
//  ViewController.h
//  Grinnell-Helpdesk-iOS
//
//  Created by Colin Tremblay on 2/11/13.
//  Copyright (c) 2013 __GrinnellAppDev__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSMutableArray *ticketArray;
}

- (void)newIssue:(id)sender;
- (void)call:(id)sender;

@property (nonatomic, weak) IBOutlet UITableView *theTableView;
@property (nonatomic, weak) IBOutlet UIImageView *noIssueImage;
@property (nonatomic, strong) NSString *cellIdentifier;

@end
