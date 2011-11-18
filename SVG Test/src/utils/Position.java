package utils;

public class Position {
	
	private double latitude;
	private double longitude;
	private double altitude;
	private float speed;
	private long time;
	
	private int x;
	private int yAltitude;
	private int ySpeed;
	
	public Position(double latitude, double longitude, double altitude,
			float speed, long time) {
		super();
		this.latitude = latitude;
		this.longitude = longitude;
		this.altitude = altitude;
		this.speed = speed;
		this.time = time;
	}

	public Position() {
		super();
		latitude = 3;
	}
	
	public String toString(){
		return String.format("%11.7f", latitude) +
			   String.format("%11.7f", longitude) +
			   String.format("%6.1f", altitude) +
			   String.format("%18.15f", speed) +
			   time;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public double getAltitude() {
		return altitude;
	}

	public void setAltitude(double altitude) {
		this.altitude = altitude;
	}

	public float getSpeed() {
		return speed;
	}

	public void setSpeed(float speed) {
		this.speed = speed;
	}

	public long getTime() {
		return time;
	}

	public void setTime(long time) {
		this.time = time;
	}

	public int getX() {
		return x;
	}

	public void setX(int x) {
		this.x = x;
	}

	public int getyAltitude() {
		return yAltitude;
	}

	public void setyAltitude(int yAltitude) {
		this.yAltitude = yAltitude;
	}

	public int getySpeed() {
		return ySpeed;
	}

	public void setySpeed(int ySpeed) {
		this.ySpeed = ySpeed;
	}
}
