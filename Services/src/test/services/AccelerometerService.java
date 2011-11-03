package test.services;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.IBinder;
import android.widget.Toast;

public class AccelerometerService extends Service 
	implements SensorEventListener {

	private SensorManager mSensorManager;
	private Sensor mSensor;
	
	private FileWriter mWriter;
	private PrintWriter mSaida;
	
	@Override
	public void onCreate() {
		super.onCreate();
		
		try{
			mSensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
			mSensor = mSensorManager.getSensorList(Sensor.TYPE_ACCELEROMETER).get(0);
			mSensorManager.registerListener(this, mSensor, SensorManager.SENSOR_DELAY_NORMAL);
		
		
			mWriter = new FileWriter(new File("/mnt/sdcard/testes/saidaAccelerometer.txt"),false);
        	mSaida = new PrintWriter(mWriter);
    		
    		mSaida.println("x\ty\tz\ttimestamp\t" + System.currentTimeMillis());
    		
    		mSaida.close();
    		mWriter.close();
    		
    		mWriter = new FileWriter(new File("/mnt/sdcard/testes/saidaAccelerometer.txt"),true);
        	mSaida = new PrintWriter(mWriter);
		}
		catch(Exception e)
		{
			Toast.makeText(getApplicationContext(), e.getMessage(),
		  	          Toast.LENGTH_SHORT).show();
		}
		
		Toast.makeText(getApplicationContext(), "Accelerometer Service succesfully started",
	  	          Toast.LENGTH_SHORT).show();
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
		mSensorManager.unregisterListener(this);
		
	}

	@Override
	public IBinder onBind(Intent intent) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void onAccuracyChanged(Sensor sensor, int accuracy) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onSensorChanged(SensorEvent event) {
		try{
			mSaida.println(event.values[0] + "\t" + event.values[1] + "\t" + event.values[2] + "\t" + 
							event.timestamp);
		}
		catch (Exception e)
		{
			Toast.makeText(getApplicationContext(), e.getMessage(),
	      	          Toast.LENGTH_SHORT).show();
		}
		
	}
}