package test.activities;

import test.services.AccelerometerService;
import test.services.GPSService;
import test.services.R;
import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ToggleButton;

public class ServicesActivity extends Activity {
	
	private boolean mAccRunning = false;
	private boolean mGPSRunning = false;
	
	private ToggleButton mAccButton;
	private ToggleButton mGPSButton;
	
	private OnClickListener mAccListener = new OnClickListener() {
	    public void onClick(View v) {
	      if(mAccRunning)
	    	  stopAccService();
	      else
	    	  startAccService();
	    }
	};
	
	private OnClickListener mGPSListener = new OnClickListener() {
	    public void onClick(View v) {
	      if(mGPSRunning)
	    	  stopGPSService();
	      else
	    	  startGPSService();
	    }
	};
	
	private OnClickListener mStartBothButton = new OnClickListener() {
	    public void onClick(View v){
	    	startServices();
	    }
	};
	
	private OnClickListener mStopBothButton = new OnClickListener() {
	    public void onClick(View v) {
	      stopServices();
	    }
	};
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        mAccButton = (ToggleButton) findViewById(R.id.AccButton);
        mAccButton.setOnClickListener(mAccListener);
        mAccButton.setChecked(false);
        
        mGPSButton = (ToggleButton) findViewById(R.id.GpsButton);
        mGPSButton.setOnClickListener(mGPSListener);
        mGPSButton.setChecked(false);
        
        final Button startBothButton = (Button) findViewById(R.id.BothOnButton);
        startBothButton.setOnClickListener(mStartBothButton);
        final Button stopBothButton = (Button) findViewById(R.id.BothOffButton);
        stopBothButton.setOnClickListener(mStopBothButton);
    }
    
    @Override
	protected void onPause() {
		super.onPause();
	}
    
    
    @Override
	protected void onDestroy() {
		super.onDestroy();
		stopServices();
	}

	@Override
	public void onConfigurationChanged(Configuration newConfig) {
		super.onConfigurationChanged(newConfig);
	}

	private void startAccService(){
    	if(!mAccRunning){
    		Intent AccelerometerIntent = new Intent(this, AccelerometerService.class);
    		startService(AccelerometerIntent);
            
    		mAccButton.setChecked(true);
            mAccRunning = true;
    	}
    }
    
    private void startGPSService(){
    	if(!mGPSRunning){
    		Intent GPSIntent = new Intent(this, GPSService.class);
    		startService(GPSIntent);
            
    		mGPSButton.setChecked(true);
            mGPSRunning = true;
    	}
    }
    
    private void startServices(){
    	startAccService();
    	startGPSService();        
    }
    
    private void stopAccService(){
    	if(mAccRunning){
    		Intent AccelerometerIntent = new Intent(this, AccelerometerService.class);
    		stopService(AccelerometerIntent);
    		
    		mAccButton.setChecked(false);
    		mAccRunning = false;
    	}
    }
    
    private void stopGPSService(){
    	if(mGPSRunning){
    		Intent GPSIntent = new Intent (this, test.services.GPSService.class);
    		stopService(GPSIntent);
    		
    		mGPSButton.setChecked(false);
    		mGPSRunning = false;
    	}
    }
    
    private void stopServices(){
    	stopAccService();
    	stopGPSService();		
    }
}
