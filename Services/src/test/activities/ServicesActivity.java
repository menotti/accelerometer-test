package test.activities;

import test.services.AccelerometerService;
import test.services.GPSService;
import test.services.R;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class ServicesActivity extends Activity {
    /** Called when the activity is first created. */
	
	public GPSService servicoGPS;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        Intent GPSIntent = new Intent(this, GPSService.class);
        startService(GPSIntent);
        
        Intent AccelerometerIntent = new Intent(this, AccelerometerService.class);
        startService(AccelerometerIntent);
        
        setContentView(R.layout.main);
        
    }
    
    @Override
	protected void onPause() {
		super.onPause();
		
		Intent GPSIntent = new Intent (this, test.services.GPSService.class);
		stopService(GPSIntent);
		
		Intent AccelerometerIntent = new Intent(this, AccelerometerService.class);
		stopService(AccelerometerIntent);
	}
}