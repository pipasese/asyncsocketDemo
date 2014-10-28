//
//  chatViewController.m
//  asyncsocketDemo
//
//  Created by vic on 14-7-21.
//  Copyright (c) 2014年 vic. All rights reserved.
//

#import "chatViewController.h"

#import "AsyncSocket.h"

#import "AsyncUdpSocket.h"
@interface chatViewController ()
{
    AsyncSocket *asyncSocket;
    AsyncUdpSocket *udpSocket;
}
@end

@implementation chatViewController

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
   
    
    UIButton *a=[[UIButton alloc]init];
    [a setFrame:CGRectMake(0, 0, 100, 100)];
    [a setBackgroundColor:[UIColor redColor]];
    [a addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *b=[[UIButton alloc]init];
    [b setFrame:CGRectMake(100, 100, 100, 100)];
    [b setBackgroundColor:[UIColor yellowColor]];
    [b addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *c=[[UIButton alloc]init];
    [c setFrame:CGRectMake(0, 300, 20, 20)];
    [c setBackgroundColor:[UIColor grayColor]];
    [c addTarget:self action:@selector(diconnect) forControlEvents:UIControlEventTouchUpInside];
	// Do any additional setup after loading the view.
    
    [self.view addSubview:a];
    [self.view addSubview:b];
    [self.view addSubview:c];
}

-(void)login
{
     [self connect];
}

-(void)diconnect
{
    [asyncSocket disconnect];
}

-(void)send
{
    NSString *tmp=@"abc\n";
    NSData *datatmp=[tmp dataUsingEncoding:NSUTF8StringEncoding];
    [asyncSocket writeData:datatmp withTimeout:-1 tag:0];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)connect
{
    asyncSocket=[[AsyncSocket alloc]initWithDelegate:self];
    NSError *err=Nil;
    [asyncSocket connectToHost:@"222.73.17.22" onPort:8888 withTimeout:-1 error:&err];
    [asyncSocket readDataWithTimeout:-1 tag:0];
    [asyncSocket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
}


-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    printf("send?:\n");
    NSLog(@"thread(%@),onSocket:%@ didWriteDataWithTag:%ld",[[NSThread currentThread] name],
          
          sock.connectedHost,tag);
}

 -(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"Info___didReadData");
	NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length])];
	NSString *msg = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
	if(msg)
	{
		NSLog(@"%@",msg);
	}
	[sock readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"error:%@",err);
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Info___didConnectToHost");
    [sock readDataWithTimeout:-1 tag:0];
  }

@end
