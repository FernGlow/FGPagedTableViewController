//
//  MainTableViewController.h
//  FGPagedTableViewController
//
//  Created by Andrew Michaelson on 7/16/12.
//  Copyright (c) 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//

#import "FGPagedTableViewController.h"
#import "ExamplePseudoService.h"

@interface MainTableViewController : FGPagedTableViewController <FGPagedTableViewControllerDelegate, FGPagedTableViewControllerDataSource>
/**
 Service that vends the data used in the example application.
 
 In a real application, this would likely be a web-service.
 
 @see ExamplePseudoService
 */
@property (nonatomic, strong) ExamplePseudoService *exampleService;
@end