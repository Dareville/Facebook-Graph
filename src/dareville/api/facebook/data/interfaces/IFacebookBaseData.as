package dareville.api.facebook.data.interfaces
{
	/**
	 * The <code>IFacebookBaseData</code> interface defines base value objects
	 * representing data on a page feed.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public interface IFacebookBaseData
	{
		/**
		 * JSON decoded Object
		 * 
		 * @return Object
		 */		
		function get data():Object;
	}
}