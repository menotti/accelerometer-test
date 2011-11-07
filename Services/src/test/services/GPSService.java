package test.services;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;

import test.utils.DateUtils;

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
		
		String strDate = DateUtils.now(true);
		try{
        	mWriter = new FileWriter(new File("/mnt/sdcard/testes/GPS " + strDate + ".txt"),false);
        	mSaida = new PrintWriter(mWriter);
    		
    		mSaida.println(String.format("%12s%12s%9s%6s%8s%9s%13s","latitude","longitude",
    				"altitude","speed","bearing","accuracy","timestamp"));
    		
    		mSaida.close();
    		mWriter.close();
    		
    		mWriter = new FileWriter(new File("/mnt/sdcard/testes/GPS " + strDate + ".txt"),true);
        	mSaida = new PrintWriter(mWriter);
        	
        }
        catch(Exception e)
        {
        	Toast.makeText(getApplicationContext(), e.getMessage(),
	      	          Toast.LENGTH_SHORT).show();
        }
	}

	@Override
	public void onLocationChanged(Location location) {
		try{
			String saida = String.format("%12.8f", location.getLatitude()) +
						   String.format("%12.8f", location.getLongitude()) +
						   String.format("%9.1f", location.getAltitude()) +
						   String.format("%6.1f", location.getSpeed()) +
						   String.format("%8.1f", location.getBearing()) +
						   String.format("%9.1f", location.getAccuracy()) +
						   String.format("%13d", location.getTime());
			mSaida.println(saida);
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
