//
//  LoginViewController.m
//  TCDB2
//
//  Created by Colin Tremblay on 12/6/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import "LoginViewController.h"
#import "IssuesViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController {
    NSMutableData *receivedData;
    NSStringEncoding encoding;
}

@synthesize username, password, goButton;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])){
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning{
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


-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    [receivedData setLength:0];
    CFStringEncoding cfEncoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)
                                                                           [response textEncodingName]);
	encoding = CFStringConvertEncodingToNSStringEncoding(cfEncoding);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to receivedData.
    [receivedData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // do something with the data
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    NSString *dataString = [[NSString alloc] initWithData:receivedData encoding:encoding];
    NSLog(@"%@", dataString);
}

- (void)go{
    @try{
        
        if([self.username.text isEqualToString:@""] || [self.password.text isEqualToString:@""]){
            [self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        }
        else{
            NSURL *url = [NSURL URLWithString:@"https://kbox.grinnell.edu/userui/check_login.php"];
            
           // NSString *post =[[NSString alloc] initWithFormat:@"login_username=%@&login_password=%@",self.username.text, self.password.text];
            //NSLog(@"PostData: %@",post);
           /* NSError *error;
            NSURL *url = [NSURL URLWithString:@"https://kbox.grinnell.edu/"];
            NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
            
            
            NSURLResponse *resp;
            [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&resp error:&error];
            NSLog(@"Response: %@", resp);
            NSLog(@"Error: %@", error);*/
            
            
            // Create the request.
            NSURLRequest *theRequest=[NSURLRequest requestWithURL:url
                                                      cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                  timeoutInterval:60.0];
            
            // create the connection with the request and start loading the data
            NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest
                                                                           delegate:self];
            
            if (theConnection){
                // Create the NSMutableData to hold the received data.
                // receivedData is an instance variable declared elsewhere.
                receivedData = [NSMutableData data];
            } else {
                // Inform the user that the connection failed.
                NSLog(@"Error occured");
            }
            
            
            
            /*
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/html" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %d", [response statusCode]);
            if([response statusCode] >= 200 && [response statusCode] < 300){
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                */
                NSInteger success;
               // if (NSNotFound == [responseData rangeOfString:@"Displaying who is logged in"].location)
                 //   success = 0;
                //else
                    success = 1;
                
                
                if(1 == success){
                    //NSLog(@"Login SUCCESS");
                    // [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                    
                    IssuesViewController *issuePage = [[IssuesViewController alloc] initWithNibName:@"IssuesViewController" bundle:nil];
                    [self.navigationController pushViewController:issuePage animated:YES];
                }
                else{
                    //NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                    [self alertStatus:nil :@"Login Failed!"];
                }
                
            /*}
            else{
                if(error)
                    NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Login Failed!"];
            }*/
        }
    }
    @catch(NSException * e){
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
}


- (IBAction)goButtonTapped:(id)sender{
    [self go];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    if (theTextField == self.password){
        [theTextField resignFirstResponder];
        [self go];
    }
    else if (theTextField == self.username)
        [self.password becomeFirstResponder];
    return YES;
}

@end
