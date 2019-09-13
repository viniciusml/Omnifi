# Omnifi

Development process:

- Initially I looked at the API structure, and parsed it using the Service class. 

- After that I set the MapView in MapViewController.

- In order to place the pins on the map, I needed to conform to the MKAnnotation protocol,
  so I created a class working as a ViewModel.
  
- I was able to place the annotations (pins) on the map, and wrote the MKMapViewDelegate methods 
  to place popups when pin is tapped. 
  
- I prepared the ViewModel to deal with possible HTML tags found in restaurant's "body", 
  observed in the API structure, and also to handle the presence of "delivery link".
  
- Then I wrote the Detail View Controller, set the UI elements and sent data to populate it,
  every time user taps on popup (MKMarkerAnnotationView) detailDisclosureButton.
  
- With this done, I handled data persistence with user defaults, implemented NSCoding protocol 
  in the ViewModel (RestaurantAnnotation) class, saved the data, and performed logic to check 
  if there's data available, and only if there is not, fetch data from API. 
  This way the app works offline after the first data fetch.
