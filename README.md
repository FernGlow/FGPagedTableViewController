FGPagedTableViewController is a [UITableViewController](http://developer.apple.com/library/ios/#documentation/uikit/reference/UITableViewController_Class/Reference/Reference.html) subclass that adds status message and paging functionality. It was modeled after Apple's server-side search functionality in the iOS Mail app.

## FGPagedTableViewController In Action

<table>
  <tr>
	<th>Status Message</th>
	<th>Paging</th>
	<th>Paging in Progress</th>
  </tr>
  <tr>
	<td><img src="http://fernglow.github.com/FGPagedTableViewController/images/FGPagedTableViewController-1-medium.png"></td>
	<td><img src="http://fernglow.github.com/FGPagedTableViewController/images/FGPagedTableViewController-2-medium.png"></td>
	<td><img src="http://fernglow.github.com/FGPagedTableViewController/images/FGPagedTableViewController-3-medium.png"></td>
  </tr>
</table>

## Getting Started

### Limitations

For simplicity, the following design is used:

- Section 1 of the table view contains the status cells (automatically provided)
- Section 2 of the table view contains the result cells (the cells your [FGPagedTableViewControllerDataSource](http://fernglow.github.com/FGPagedTableViewController/Documentation/Protocols/FGPagedTableViewControllerDataSource.html) provides)
- Section 3 of the table view contains the paging cells (automatically provided)

Because of the current design, multi-section table view's are not supported. I encourage pull requests for an improved design that supports this.

### Important

You do not need to, and shouldn't, implement any of the following UITableView data source or delegate methods as they are all handled by the FGPagedTableViewController class:

- [-tableView:cellForRowAtIndexPath:](http://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewDataSource_Protocol/Reference/Reference.html#//apple_ref/occ/intfm/UITableViewDataSource/tableView:cellForRowAtIndexPath:)
- [-numberOfSectionsInTableView:](http://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewDataSource_Protocol/Reference/Reference.html#//apple_ref/occ/intfm/UITableViewDataSource/numberOfSectionsInTableView:)
- [-tableView:numberOfRowsInSection:](http://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewDataSource_Protocol/Reference/Reference.html#//apple_ref/occ/intfm/UITableViewDataSource/tableView:numberOfRowsInSection:)

If you call any of the following data source or delegate methods, you must remember to call super's implementation:

- [– tableView:didSelectRowAtIndexPath:](http://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewDelegate_Protocol/Reference/Reference.html#//apple_ref/occ/intfm/UITableViewDelegate/tableView:didSelectRowAtIndexPath:)

### 1. Subclass the controller and adopt the delegate and data source protocols

```objective-c
@interface ExamplePagedTableViewController : FGPagedTableViewController <FGPagedTableViewControllerDelegate, FGPagedTableViewControllerDataSource>
```

### 2. Implement the required delegate and data source methods

```objective-c
- (UITableViewCell *)pagedTableView:(UITableView *)tableView resultCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
	// configure cell properties
	return cell;
}

- (NSInteger)numberOfRowsInPagedData
{
	// return number of items to be paged through
}

- (void)pagedTableView:(UITableView *)tableView didSelectPagingCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// request a new page of data
}
```

### 3. Update the pageInfo object after you receive new data for the table view

```objective-c
// Create a new PageInfo instance
PageInfo *pageInfo = [[PageInfo alloc] init];

// configure pageInfo according to your data source
pageInfo.totalResults = 26;
pageInfo.totalPages = 6;
pageInfo.page = 1;

// update pageInfo with the latest paging information
// this triggers updates to the tableView, so do this last.
self.pageInfo = pageInfo;
```
## Documentation

Read the [full documentation](http://fernglow.github.com/FGPagedTableViewController/Documentation/html/index.html)

## Requirements

- iOS 5.1.1
- Apple LLVM 4.0+ (ARC, auto-synthesize, literals and subscripting)

## Contributions

Feel free to fork and submit pull requests. This project is very early in development and I'm open to any improvements.

## License

FGPagedTableViewController is available under the MIT license. See the LICENSE file for more info.