

public class Coordenates {

	private float x;
	private float y;
	private float z;
	private long timestamp;
	
	public Coordenates(float x, float y, float z, long timestamp) {
		super();
		this.x = x;
		this.y = y;
		this.z = z;
		this.timestamp = timestamp;
	}
	
	public Coordenates(){
		x=0;
		y=0;
		z=0;
		timestamp=0;
	}
	
	public String toString(){
		String retorno = String.format("%11.7f",x) + 
						 String.format("%11.7f",y) +
						 String.format("%11.7f",z) +
						 String.format("%11d",timestamp);
		retorno = retorno.replace(',','.');
		return retorno;
	}
	
	public Coordenates fromString(String coordenatesStr){
		if(coordenatesStr.length()!=44){
			return null;
		}
		x = Float.valueOf(coordenatesStr.substring(0, 11));
		y = Float.valueOf(coordenatesStr.substring(11, 22));
		z = Float.valueOf(coordenatesStr.substring(22, 33));
		timestamp = Long.valueOf(coordenatesStr.substring(33, 44).replace(' ', '0'));
		Coordenates retorno = new Coordenates(x,y,z,timestamp);
		return retorno;
	}

	public float getX() {
		return x;
	}

	public void setX(float x) {
		this.x = x;
	}

	public float getY() {
		return y;
	}

	public void setY(float y) {
		this.y = y;
	}

	public float getZ() {
		return z;
	}

	public void setZ(float z) {
		this.z = z;
	}

	public long getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(long timestamp) {
		this.timestamp = timestamp;
	}
	
	public String getXvirgula(){
		String s = String.format("%11.7f",x);
		s.replace('.', ',');
		s.replace(' ', '0');
		return s;
	}
	
	public String getYvirgula(){
		String s = String.format("%11.7f",y);
		s.replace('.', ',');
		s.replace(' ', '0');
		return s;
	}
	
	public String getZvirgula(){
		String s = String.format("%11.7f",z);
		s.replace('.', ',');
		s.replace(' ', '0');
		return s;
	}
}
