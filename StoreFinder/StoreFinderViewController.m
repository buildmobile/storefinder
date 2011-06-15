#import "StoreFinderViewController.h"

@implementation StoreFinderViewController

@synthesize locationManager;

- (void)dealloc
{
    [super dealloc];
    [self.locationManager release];
    if ( locations )
        [locations release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locations = NULL;
    
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

// Table data delegate
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if ( locations != NULL ) {
        return [locations count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyIdentifier"] autorelease];
    }
    
    NSDictionary *itemAtIndex = (NSDictionary *)[locations objectAtIndex:indexPath.row];
	UILabel *newCellLabel = [cell textLabel];
    
	[newCellLabel setText:[itemAtIndex objectForKey:@"name"]];

	return cell;
}

// XML request and parsing
- (void)updateLocation:(CLLocation *)newLocation {
    if ( locations ) {
        [locations release];
    }
    locations = [[NSMutableArray alloc] init];
    
    if ( newLocation ) {
        latitude = newLocation.coordinate.latitude;
        longitude = newLocation.coordinate.longitude;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://localhost/geo/circle.php?lat=%g&lon=%g&radius=100&q=%@", 
                           latitude, longitude, searchBar.text?searchBar.text:@""];

    NSXMLParser *locationParser = [[[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]] autorelease];
    [locationParser setDelegate:self];
    [locationParser parse];
    
    [tableView reloadData];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ( [elementName isEqualToString:@"location"]) {
        [locations addObject:[[NSDictionary alloc] initWithDictionary:attributeDict]];
    }
}

// GPS handling
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [self updateLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
}

// Search bar handling
- (void)searchBarSearchButtonClicked:(UISearchBar *)sb {
    [self updateLocation:NULL];
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)sb
{
    [searchBar resignFirstResponder];
}

@end
