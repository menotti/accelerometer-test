package test.gps;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;

import android.app.Activity;
import android.content.Context;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

public class GPSActivity extends Activity implements LocationListener{
        
        private LocationManager locationManager;
        
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
        locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, this);
        
        Location location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
        if (location != null) {
            ((TextView) findViewById(R.id.lat)).setText(String.valueOf(location.getLatitude()));
			((TextView) findViewById(R.id.lng)).setText(String.valueOf(location.getLongitude()));
			((TextView) findViewById(R.id.alt)).setText(String.valueOf(location.getAltitude()));                
			((TextView) findViewById(R.id.vel)).setText(String.valueOf(location.getSpeed()));
			((TextView) findViewById(R.id.brn)).setText(String.valueOf(location.getBearing()));
			((TextView) findViewById(R.id.tmp)).setText(String.valueOf(location.getTime()));
        }
        else
        {
        	((TextView) findViewById(R.id.lat)).setText("latitude");
    		((TextView) findViewById(R.id.lng)).setText("longitude");
    		((TextView) findViewById(R.id.alt)).setText("altitude");
    		((TextView) findViewById(R.id.vel)).setText("velocidade");
    		((TextView) findViewById(R.id.brn)).setText("bearing");
    		((TextView) findViewById(R.id.tmp)).setText("tempo");
        }
        try{
        	FileWriter writer = new FileWriter(new File("/mnt/sdcard/testes/saida.txt"),false);
        	PrintWriter saida = new PrintWriter(writer);
    		
    		saida.println("latitude longitude altitude speed bearing time");
    		
    		saida.close();
    		writer.close();
        }
        catch(Exception e)
        {
        	Toast.makeText(getApplicationContext(), e.getMessage(),
	      	          Toast.LENGTH_SHORT).show();
        }
    }

        @Override
        public void onLocationChanged(Location location) {
                if (location != null) {
                	double latitude = location.getLatitude();
                	double longitude = location.getLongitude();
                	double altitude = location.getAltitude();
                	double speed = location.getSpeed();
                	double bearing = location.getBearing();
                	double time = location.getTime();
                	
                    ((TextView) findViewById(R.id.lat)).setText(String.valueOf(latitude));
        			((TextView) findViewById(R.id.lng)).setText(String.valueOf(longitude));
        			((TextView) findViewById(R.id.alt)).setText(String.valueOf(altitude));                
        			((TextView) findViewById(R.id.vel)).setText(String.valueOf(speed));
        			((TextView) findViewById(R.id.brn)).setText(String.valueOf(bearing));
        			((TextView) findViewById(R.id.tmp)).setText(String.valueOf(time)); 
        			try{
        				FileWriter writer = new FileWriter(new File("/mnt/sdcard/testes/saida.txt"),true);
        				PrintWriter saida = new PrintWriter(writer);
        				
        				saida.println(latitude + " " + longitude + " " + altitude + " " + 
        								speed + " " + bearing + " " + time);
        				
        				saida.close();  
        				writer.close();
        			}
        			catch (Exception e)
        			{
        				Toast.makeText(getApplicationContext(), e.getMessage(),
        		      	          Toast.LENGTH_SHORT).show();
        			}
            	}
        }

        @Override
        public void onProviderDisabled(String provider) {
                Toast.makeText(this, "Disenabled provider " + provider,
                                Toast.LENGTH_SHORT).show();
                
        }

        @Override
        public void onProviderEnabled(String provider) {
                Toast.makeText(this, "Enabled new provider " + provider,
                                Toast.LENGTH_SHORT).show();
                
        }

        @Override
        public void onStatusChanged(String provider, int status, Bundle extras) {
                // TODO Auto-generated method stub
                
        }
        
        @Override
        protected void onPause() {
                super.onPause();
                locationManager.removeUpdates(this);
        }
        @Override
        protected void onResume() {
                super.onResume();
                locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, this);
        }
}