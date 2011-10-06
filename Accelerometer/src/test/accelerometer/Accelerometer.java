package test.accelerometer;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.os.PowerManager;
import android.widget.TextView;
import android.widget.Toast;
 
/**
 * Android accelerometer sensor tutorial
 * @author antoine vianey
 * under GPL v3 : http://www.gnu.org/licenses/gpl-3.0.html
 */
public class Accelerometer extends Activity 
        implements AccelerometerListener {
 
    private static Context CONTEXT;
    private float xmin = 0;
    private float xmax = 0;
    protected PowerManager.WakeLock mWakeLock;
 
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        final PowerManager pm = (PowerManager) getSystemService(Context.POWER_SERVICE);
        this.mWakeLock = pm.newWakeLock(PowerManager.SCREEN_DIM_WAKE_LOCK, "My Tag");
        this.mWakeLock.acquire();

        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        CONTEXT = this;
        
    }
 
    protected void onResume() {
        super.onResume();
        if (AccelerometerManager.isSupported()) {
            AccelerometerManager.startListening(this);
        }
    }
 
    protected void onDestroy() {
        super.onDestroy();
        if (AccelerometerManager.isListening()) {
            AccelerometerManager.stopListening();
        }
        this.mWakeLock.release();
    }
 
    public static Context getContext() {
        return CONTEXT;
    }
 
    /**
     * onShake callback
     */
    public void onShake(float force) {
        Toast.makeText(this, "Phone shaked : " + force, 1000).show();
    }
 
    /**
     * onAccelerationChanged callback
     */
    public void onAccelerationChanged(float x, float y, float z) {
    	
    	if (x<xmin)
    		xmin = x;
    	if (x>xmax)
    		xmax = x;
    	
        ((TextView) findViewById(R.id.x)).setText(String.valueOf(x));
        ((TextView) findViewById(R.id.xmin)).setText(String.valueOf(xmin));
        ((TextView) findViewById(R.id.xmax)).setText(String.valueOf(xmax));
        ((TextView) findViewById(R.id.y)).setText(String.valueOf(y));
        ((TextView) findViewById(R.id.z)).setText(String.valueOf(z));
    }
 
}