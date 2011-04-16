//
//  MapAddressViewController.m
//  MapAddress
//
//  Created by Dener Wilian Pereira do Carmo on 04/04/11.
//  Copyright 2011 Agence. All rights reserved.
//

#import "MapAddressViewController.h"
#import "CJSONDeserializer.h"
#import "JSON/JSON.h"



@implementation MapAddressViewController

@synthesize mapView, segmentControlMapType,searchBar;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    mapView.mapType = MKMapTypeStandard;

    [super viewDidLoad];
    //searchBar = [[UISearchBar alloc] init];
  //  searchBar.delegate = self;
  
}

-(IBAction) changeMapType:(id)sender {
  
  switch ( segmentControlMapType.selectedSegmentIndex) {
    case 0:
      mapView.mapType = MKMapTypeStandard;
      break;
    case 1:
      mapView.mapType = MKMapTypeSatellite;
      break;
    case 2:
      mapView.mapType = MKMapTypeHybrid;
      break;

  } 
}

//-(void)searchBar:textDidChange:(UISearchBar*)theSearchBar {
//}
//-(void)searchBarShouldBeginEditing:(UISearchBar*)theSearchBar {
//}
//-(void)searchBarTextDidBeginEditing:(UISearchBar*)theSearchBar {
//}
//-(void)searchBarShouldEndEditing:(UISearchBar*)theSearchBar {
//}
//-(void)searchBarTextDidEndEditing:(UISearchBar*)theSearchBar {
//}
//-(void)searchBarBookmarkButtonClicked:(UISearchBar*)theSearchBar {
//}
//-(void)searchBarCancelButtonClicked:(UISearchBar*)theSearchBar {
//}
//* – searchBarShouldEndEditing:
//* – searchBarTextDidEndEditing:

//- (void) searchBarDidBeginEditing:(UISearchBar*)theSearchBar {
//  theSearchBar.showsCancelButton = YES;
//}
//
-(void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
  [self searchCoordinatesByAddress:[searchBar text]];
  
  [searchBar resignFirstResponder];
}
//


-(void)searchCoordinatesByAddress:(NSString*)address {
  
  NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@?output=json",address];
  
  [urlString setString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
  
  NSURL *url = [NSURL URLWithString:urlString];

  
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  [connection release];
  [request release];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{   
  //The string received from google's servers
  NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  
  CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
    NSError **error;
    NSDictionary *results = [jsonDeserializer deserializeAsDictionary:data error:error]; 
  
  //Now we need to obtain our coordinates
  NSArray *placemark  = [results objectForKey:@"Placemark"];
  NSArray *coordinates = [[placemark objectAtIndex:0] valueForKeyPath:@"Point.coordinates"];
  
  //I put my coordinates in my array.
  double longitude = [[coordinates objectAtIndex:0] doubleValue];
  double latitude = [[coordinates objectAtIndex:1] doubleValue];
  
  //Debug.
  //NSLog(@"Latitude - Longitude: %f %f", latitude, longitude);
  
  //I zoom my map to the area in question.
  [self zoomMapAndCenterAtLatitude:latitude andLongitude:longitude];
  
  [jsonString release];
}

-(void) zoomMapAndCenterAtLatitude:(double) latitude andLongitude:(double) longitude
{
  MKCoordinateRegion region;
  region.center.latitude  = latitude;
  region.center.longitude = longitude;
  
  //Set Zoom level using Span
  MKCoordinateSpan span;
  span.latitudeDelta  = .005;
  span.longitudeDelta = .005;
  region.span = span;
  
  //Move the map and zoom
  [mapView setRegion:region animated:YES];
}




/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
