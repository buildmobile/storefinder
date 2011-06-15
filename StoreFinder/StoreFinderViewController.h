#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface StoreFinderViewController : UIViewController<UITableViewDataSource,
        CLLocationManagerDelegate,
        NSXMLParserDelegate,
        UISearchBarDelegate> {
    IBOutlet UISearchBar *searchBar;
    IBOutlet UITableView *tableView;

    CLLocationManager *locationManager;
    
    NSMutableArray *locations;

    float latitude;
    float longitude;
}

@property (nonatomic, retain) CLLocationManager *locationManager;  

@end
