//
//  Ticket.h
//  Grinnell-Helpdesk-iOS
//
//  Created by Lea Marolt on 3/3/13.
//
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSDate *modified;
@property (nonatomic, strong) NSMutableArray *commentsArray;
@property (nonatomic, strong) NSString *comment;
@end
