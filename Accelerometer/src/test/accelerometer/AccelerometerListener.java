package test.accelerometer;

public interface AccelerometerListener {
	 
	public void onAccelerationChanged(float x, float y, float z, long timestamp);
 
	//public void onShake(float force);
 
}
