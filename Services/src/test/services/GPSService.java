package test.services;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.IBinder;
import android.widget.Toast;

public class GPSService extends Service implements LocationListener {

	private LocationManager mLocationManager;
	
	private FileWriter mWriter;
	private PrintWriter mSaida;

	@Override
	public void onCreate() {
		super.onCreate();
		
		mLocationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
		mLocationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, this);
		
		try{
        	mWriter = new FileWriter(new File("/mnt/sdcard/testes/saidaGPS.txt"),false);
        	mSaida = new PrintWriter(mWriter);
    		
    		mSaida.println("latitude\tlongitude\taltitude\tspeed\tbearing\taccuracy\ttime\t" + System.currentTimeMillis());
    		
    		mSaida.close();
    		mWriter.close();
    		
    		mWriter = new FileWriter(new File("/mnt/sdcard/testes/saidaGPS.txt"),true);
        	mSaida = new PrintWriter(mWriter);
        	
        }
        catch(Exception e)
        {
        	Toast.makeText(getApplicationContext(), e.getMessage(),
	      	          Toast.LENGTH_SHORT).show();
        }
		
		Toast.makeText(getApplicationContext(), "GPS Service succesfully started",
  	          Toast.LENGTH_SHORT).show();
		
	}

	@Override
	public void onLocationChanged(Location location) {
		try{
			mSaida.println(location.getLatitude() + "\t" + location.getLongitude() + "\t" + location.getAltitude() + "\t" + 
							location.getSpeed() + "\t" + location.getBearing() + "\t" + location.getAccuracy() + "\t" + 
							location.getTime());
		}
		catch (Exception e)
		{
			Toast.makeText(getApplicationContext(), e.getMessage(),
	      	          Toast.LENGTH_SHORT).show();
		}

	}

	@Override
	public void onDestroy() {
		super.onDestroy();
		try{
			mSaida.close();
			mWriter.close();
		}
		catch(Exception e){
			Toast.makeText(getApplicationContext(), e.getMessage(),
	      	          Toast.LENGTH_SHORT).show();
		}
		mLocationManager.removeUpdates(this);
	}

	@Override
	public void onProviderDisabled(String provider) {
		Toast.makeText(getApplicationContext(), "Provider disabled",
    	          Toast.LENGTH_SHORT).show();
	}

	@Override
	public void onProviderEnabled(String provider) {
		Toast.makeText(getApplicationContext(), "Provider enabled",
  	          Toast.LENGTH_SHORT).show();
	}

	@Override
	public void onStatusChanged(String provider, int status, Bundle extras) {
		// TODO Auto-generated method stub

	}

	@Override
	public IBinder onBind(Intent arg0) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
