package test.services;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;

import test.utils.DateUtils;

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

			String strDate = DateUtils.now(true);
		
			mWriter = new FileWriter(new File("/mnt/sdcard/testes/Acc " + strDate + ".txt"),false);
        	mSaida = new PrintWriter(mWriter);
    		
    		mSaida.println(String.format("%6s%12s%12s%18s",'x','y','z',"timestamp"));
    		
    		mSaida.close();
    		mWriter.close();
    		
    		mWriter = new FileWriter(new File("/mnt/sdcard/testes/Acc " + strDate + ".txt"),true);
        	mSaida = new PrintWriter(mWriter);
		}
		catch(Exception e)
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
			String saida = String.format("%12.8f", event.values[0]) +
						   String.format("%12.8f", event.values[1]) +
						   String.format("%12.8f", event.values[2]) +
						   String.format("%14d", event.timestamp);
			mSaida.println(saida);
		}
		catch (Exception e)
		{
			Toast.makeText(getApplicationContext(), e.getMessage(),
	      	          Toast.LENGTH_SHORT).show();
		}
	}
}