var locations = [
      ['Šibenik',43.732513, 15.899000, 4, 'Ovo je opis', 0],
      ['Zadar', 44.120234, 15.238447, 5, 'Pak drugi opis', 1],
      ['Kornati', 43.823736, 15.292005, 3, 'Netko treći?',1],
      ['NP Krka', 43.855433, 15.970411, 2, 'Još uvijek opisujemo?',0],
      ['Split', 43.510820, 16.435957, 1,'Nah, we\'re done', 1]
    ];

    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 9,
      center: new google.maps.LatLng(43.764259, 15.775404),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });

    var infowindow = new google.maps.InfoWindow();
	var image = {
		url: 'img/adrenaline.png',
		size: new google.maps.Size(32, 37),
		origin: new google.maps.Point(0,0),
		anchor: new google.maps.Point(16, 37)
	};  

	var shape = {
		coords: [1, 1, 1, 32, 30, 32, 30 , 1],
		type: 'poly'
	};
    var marker, i;

    for (i = 0; i < locations.length; i++) {

          marker = new google.maps.Marker({
            position: new google.maps.LatLng(locations[i][1], locations[i][2]),
            map: map,
            icon: image,
            shape: shape
          });

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent(locations[i][4]);
          infowindow.open(map, marker);
        }
      })(marker, i));
    }