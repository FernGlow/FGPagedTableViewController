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

### Subclass the controller and adopt the delegate and data source protocols

```objective-c
@interface ExamplePagedTableViewController : FGPagedTableViewController <FGPagedTableViewControllerDelegate, FGPagedTableViewControllerDataSource>
```

### Implement the required delegate and data source methods

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

### Update the pageInfo object after you receive new data

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

Read the [full documentation](http://fernglow.github.com/FGPagedTableViewController/Documentation/)

## Requirements

FGPagedTableViewController uses ARC and modern Objective-C features such as auto-synthesize, literals and subscripting. Thus, it must be compiled with Apple LLVM 4.0+.

## License

FGPagedTableViewController is available under the MIT license. See the LICENSE file for more info.